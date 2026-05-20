#!/usr/bin/env python3
"""
Minimal local OCPP 1.6J CSMS demo.

It intentionally uses only the Python standard library so it can run on a
developer PC without installing packages:

    python3 cloud/ocpp_local_server.py --host 0.0.0.0 --port 9000

Point the charger to:

    ws://<pc-ip>:9000/ocpp

libocpp appends the charge box id, so the final WebSocket path becomes
/ocpp/<charge-box-id>.
"""

from __future__ import annotations

import argparse
import asyncio
import base64
import hashlib
import json
import socket
import struct
import time
from collections import deque
from datetime import datetime, timezone
from typing import Any
from urllib.parse import unquote, urlsplit


GUID = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11"
CALL = 2
CALLRESULT = 3
CALLERROR = 4

EVENTS: deque[dict[str, Any]] = deque(maxlen=300)
SSE_CLIENTS: set[asyncio.StreamWriter] = set()
STATIONS: dict[str, dict[str, Any]] = {}
NEXT_TRANSACTION_ID = 1000
HEARTBEAT_INTERVAL = 30


def utc_now() -> str:
    return datetime.now(timezone.utc).isoformat(timespec="seconds").replace("+00:00", "Z")


def local_ip_hint() -> str:
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as sock:
            sock.connect(("8.8.8.8", 80))
            return sock.getsockname()[0]
    except OSError:
        return "127.0.0.1"


def parse_http_headers(raw: bytes) -> tuple[str, str, str, dict[str, str]]:
    text = raw.decode("iso-8859-1")
    lines = text.split("\r\n")
    method, target, version = lines[0].split(" ", 2)
    headers: dict[str, str] = {}
    for line in lines[1:]:
        if not line or ":" not in line:
            continue
        key, value = line.split(":", 1)
        headers[key.strip().lower()] = value.strip()
    return method, target, version, headers


def station_from_path(target: str) -> str:
    path = urlsplit(target).path.rstrip("/")
    if not path:
        return "unknown"
    if path.startswith("/ocpp/"):
        return unquote(path.rsplit("/", 1)[-1]) or "unknown"
    return unquote(path.strip("/").rsplit("/", 1)[-1]) or "unknown"


async def publish_event(station: str, direction: str, action: str, payload: Any) -> None:
    event = {
        "ts": utc_now(),
        "station": station,
        "direction": direction,
        "action": action,
        "payload": payload,
    }
    EVENTS.appendleft(event)
    data = f"data: {json.dumps(event, separators=(',', ':'))}\n\n".encode()

    dead: list[asyncio.StreamWriter] = []
    for writer in SSE_CLIENTS:
        try:
            writer.write(data)
            await writer.drain()
        except (ConnectionError, RuntimeError):
            dead.append(writer)
    for writer in dead:
        SSE_CLIENTS.discard(writer)


def http_response(
    writer: asyncio.StreamWriter,
    status: str,
    body: bytes,
    content_type: str = "text/plain; charset=utf-8",
    extra_headers: dict[str, str] | None = None,
) -> None:
    headers = {
        "Content-Type": content_type,
        "Content-Length": str(len(body)),
        "Connection": "close",
        "Cache-Control": "no-store",
    }
    if extra_headers:
        headers.update(extra_headers)
    writer.write(f"HTTP/1.1 {status}\r\n".encode())
    for key, value in headers.items():
        writer.write(f"{key}: {value}\r\n".encode())
    writer.write(b"\r\n")
    writer.write(body)


def dashboard_html() -> bytes:
    return b"""<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Local OCPP CSMS</title>
<style>
:root { color-scheme: dark; font-family: Inter, system-ui, sans-serif; background:#101214; color:#e7ecef; }
body { margin:0; }
header { padding:18px 22px; border-bottom:1px solid #2a3035; display:flex; justify-content:space-between; gap:16px; align-items:center; }
h1 { font-size:20px; margin:0; letter-spacing:0; }
main { padding:20px; display:grid; grid-template-columns:320px 1fr; gap:18px; }
.panel { border:1px solid #2a3035; border-radius:8px; background:#15191d; overflow:hidden; }
.panel h2 { margin:0; padding:12px 14px; font-size:14px; border-bottom:1px solid #2a3035; }
#stations { padding:12px; display:grid; gap:10px; }
.station { border:1px solid #303840; border-radius:6px; padding:10px; background:#111417; }
.station strong { display:block; margin-bottom:8px; }
.kv { display:grid; grid-template-columns:94px 1fr; gap:4px 8px; font-size:12px; color:#bac4cc; }
table { width:100%; border-collapse:collapse; font-size:12px; }
th, td { padding:9px 10px; border-bottom:1px solid #252b31; vertical-align:top; }
th { text-align:left; color:#9fb0bc; background:#111417; position:sticky; top:0; }
code { white-space:pre-wrap; word-break:break-word; color:#d5e6f3; }
.in { color:#69d28f; font-weight:700; }
.out { color:#78a6ff; font-weight:700; }
.muted { color:#8a98a3; }
@media (max-width: 860px) { main { grid-template-columns:1fr; } }
</style>
</head>
<body>
<header>
  <h1>Local OCPP 1.6J CSMS</h1>
  <div class="muted">WebSocket: <code>ws://&lt;this-pc&gt;:9000/ocpp</code></div>
</header>
<main>
  <section class="panel">
    <h2>Stations</h2>
    <div id="stations"><span class="muted">Waiting for charger...</span></div>
  </section>
  <section class="panel">
    <h2>Messages</h2>
    <table>
      <thead><tr><th>Time</th><th>Dir</th><th>Station</th><th>Action</th><th>Payload</th></tr></thead>
      <tbody id="messages"></tbody>
    </table>
  </section>
</main>
<script>
const events = [];
const stations = {};
const messagesEl = document.getElementById('messages');
const stationsEl = document.getElementById('stations');

function updateStation(ev) {
  const st = stations[ev.station] || { id: ev.station, last: ev.ts, status: 'Connected', connectors: {} };
  st.last = ev.ts;
  if (ev.action === 'BootNotification') {
    st.vendor = ev.payload.chargePointVendor || '';
    st.model = ev.payload.chargePointModel || '';
  }
  if (ev.action === 'StatusNotification') {
    const id = ev.payload.connectorId || 0;
    st.connectors[id] = ev.payload.status || 'Unknown';
  }
  if (ev.action === 'MeterValues') {
    st.lastMeter = ev.payload;
  }
  stations[ev.station] = st;
}

function renderStations() {
  const list = Object.values(stations);
  if (!list.length) {
    stationsEl.innerHTML = '<span class="muted">Waiting for charger...</span>';
    return;
  }
  stationsEl.innerHTML = list.map(st => {
    const connectors = Object.entries(st.connectors).map(([id, s]) => `#${id}: ${s}`).join(', ') || 'none';
    return `<div class="station"><strong>${st.id}</strong><div class="kv">
      <span>Last seen</span><span>${st.last}</span>
      <span>Model</span><span>${st.vendor || ''} ${st.model || ''}</span>
      <span>Connectors</span><span>${connectors}</span>
    </div></div>`;
  }).join('');
}

function renderMessages() {
  messagesEl.innerHTML = events.slice(0, 80).map(ev => `
    <tr>
      <td>${ev.ts}</td>
      <td class="${ev.direction}">${ev.direction}</td>
      <td>${ev.station}</td>
      <td>${ev.action}</td>
      <td><code>${JSON.stringify(ev.payload, null, 2)}</code></td>
    </tr>`).join('');
}

function addEvent(ev) {
  if (events.some(existing => existing.ts === ev.ts && existing.station === ev.station &&
      existing.direction === ev.direction && existing.action === ev.action &&
      JSON.stringify(existing.payload) === JSON.stringify(ev.payload))) return;
  events.unshift(ev);
  updateStation(ev);
  renderStations();
  renderMessages();
}

const source = new EventSource('/events');
source.onmessage = evt => addEvent(JSON.parse(evt.data));
</script>
</body>
</html>
"""


def response_for(action: str, payload: dict[str, Any]) -> dict[str, Any]:
    global NEXT_TRANSACTION_ID

    if action == "BootNotification":
        return {"currentTime": utc_now(), "interval": HEARTBEAT_INTERVAL, "status": "Accepted"}
    if action == "Heartbeat":
        return {"currentTime": utc_now()}
    if action == "Authorize":
        return {"idTagInfo": {"status": "Accepted"}}
    if action == "StartTransaction":
        NEXT_TRANSACTION_ID += 1
        return {"transactionId": NEXT_TRANSACTION_ID, "idTagInfo": {"status": "Accepted"}}
    if action == "StopTransaction":
        return {"idTagInfo": {"status": "Accepted"}}
    if action == "DataTransfer":
        return {"status": "Accepted"}
    if action == "DiagnosticsStatusNotification":
        return {}
    if action == "FirmwareStatusNotification":
        return {}
    if action == "MeterValues":
        return {}
    if action == "StatusNotification":
        return {}
    return {}


async def read_ws_frame(reader: asyncio.StreamReader) -> tuple[int, bytes]:
    first = await reader.readexactly(2)
    opcode = first[0] & 0x0F
    masked = (first[1] & 0x80) != 0
    length = first[1] & 0x7F
    if length == 126:
        length = struct.unpack("!H", await reader.readexactly(2))[0]
    elif length == 127:
        length = struct.unpack("!Q", await reader.readexactly(8))[0]

    mask = await reader.readexactly(4) if masked else b""
    payload = await reader.readexactly(length) if length else b""
    if masked:
        payload = bytes(byte ^ mask[index % 4] for index, byte in enumerate(payload))
    return opcode, payload


async def send_ws_frame(writer: asyncio.StreamWriter, opcode: int, payload: bytes) -> None:
    header = bytearray([0x80 | opcode])
    length = len(payload)
    if length < 126:
        header.append(length)
    elif length <= 0xFFFF:
        header.append(126)
        header.extend(struct.pack("!H", length))
    else:
        header.append(127)
        header.extend(struct.pack("!Q", length))
    writer.write(bytes(header) + payload)
    await writer.drain()


async def send_ws_text(writer: asyncio.StreamWriter, message: Any) -> None:
    if not isinstance(message, str):
        message = json.dumps(message, separators=(",", ":"))
    await send_ws_frame(writer, 1, message.encode("utf-8"))


async def handle_ocpp_message(station: str, text: str, writer: asyncio.StreamWriter) -> None:
    try:
        message = json.loads(text)
    except json.JSONDecodeError as exc:
        await publish_event(station, "in", "InvalidJson", {"raw": text, "error": str(exc)})
        return

    if not isinstance(message, list) or not message:
        await publish_event(station, "in", "InvalidOcpp", message)
        return

    message_type = message[0]
    if message_type == CALL and len(message) >= 4:
        unique_id = message[1]
        action = str(message[2])
        payload = message[3] if isinstance(message[3], dict) else {}
        STATIONS.setdefault(station, {"connectedAt": utc_now(), "lastSeen": utc_now()})["lastSeen"] = utc_now()
        await publish_event(station, "in", action, payload)

        response_payload = response_for(action, payload)
        response = [CALLRESULT, unique_id, response_payload]
        await send_ws_text(writer, response)
        await publish_event(station, "out", f"{action}Response", response_payload)
    elif message_type == CALLRESULT and len(message) >= 3:
        await publish_event(station, "in", "CallResult", message[2])
    elif message_type == CALLERROR:
        await publish_event(station, "in", "CallError", message)
    else:
        await publish_event(station, "in", "UnknownOcpp", message)


async def handle_websocket(
    reader: asyncio.StreamReader,
    writer: asyncio.StreamWriter,
    target: str,
    headers: dict[str, str],
) -> None:
    key = headers.get("sec-websocket-key")
    if not key:
        http_response(writer, "400 Bad Request", b"Missing Sec-WebSocket-Key\n")
        await writer.drain()
        writer.close()
        await writer.wait_closed()
        return

    accept = base64.b64encode(hashlib.sha1((key + GUID).encode()).digest()).decode()
    protocols = [p.strip() for p in headers.get("sec-websocket-protocol", "").split(",") if p.strip()]
    selected_protocol = "ocpp1.6" if "ocpp1.6" in protocols else (protocols[0] if protocols else "")
    response_headers = [
        "HTTP/1.1 101 Switching Protocols",
        "Upgrade: websocket",
        "Connection: Upgrade",
        f"Sec-WebSocket-Accept: {accept}",
    ]
    if selected_protocol:
        response_headers.append(f"Sec-WebSocket-Protocol: {selected_protocol}")
    writer.write(("\r\n".join(response_headers) + "\r\n\r\n").encode())
    await writer.drain()

    station = station_from_path(target)
    await publish_event(station, "in", "WebSocketConnected", {"path": urlsplit(target).path})

    try:
        while not writer.is_closing():
            opcode, payload = await read_ws_frame(reader)
            if opcode == 8:
                await send_ws_frame(writer, 8, b"")
                break
            if opcode == 9:
                await send_ws_frame(writer, 10, payload)
                continue
            if opcode == 1:
                await handle_ocpp_message(station, payload.decode("utf-8"), writer)
    except (asyncio.IncompleteReadError, ConnectionError):
        pass
    finally:
        await publish_event(station, "in", "WebSocketDisconnected", {})
        writer.close()
        try:
            await writer.wait_closed()
        except ConnectionError:
            pass


async def handle_sse(writer: asyncio.StreamWriter) -> None:
    writer.write(
        b"HTTP/1.1 200 OK\r\n"
        b"Content-Type: text/event-stream\r\n"
        b"Cache-Control: no-store\r\n"
        b"Connection: keep-alive\r\n\r\n"
    )
    for event in reversed(EVENTS):
        writer.write(f"data: {json.dumps(event, separators=(',', ':'))}\n\n".encode())
    await writer.drain()

    SSE_CLIENTS.add(writer)
    try:
        while not writer.is_closing():
            writer.write(f": ping {time.time()}\n\n".encode())
            await writer.drain()
            await asyncio.sleep(15)
    except (ConnectionError, RuntimeError, asyncio.CancelledError):
        pass
    finally:
        SSE_CLIENTS.discard(writer)
        writer.close()


async def handle_http_client(reader: asyncio.StreamReader, writer: asyncio.StreamWriter) -> None:
    try:
        raw = await asyncio.wait_for(reader.readuntil(b"\r\n\r\n"), timeout=10)
        method, target, _version, headers = parse_http_headers(raw)
    except Exception:
        writer.close()
        await writer.wait_closed()
        return

    upgrade = headers.get("upgrade", "").lower() == "websocket"
    if upgrade:
        await handle_websocket(reader, writer, target, headers)
        return

    path = urlsplit(target).path
    if method != "GET":
        http_response(writer, "405 Method Not Allowed", b"Only GET is supported\n")
    elif path == "/":
        http_response(writer, "200 OK", dashboard_html(), "text/html; charset=utf-8")
    elif path == "/events":
        await handle_sse(writer)
        return
    elif path == "/api/events":
        body = json.dumps({"events": list(EVENTS), "stations": STATIONS}, indent=2).encode()
        http_response(writer, "200 OK", body, "application/json; charset=utf-8")
    elif path == "/healthz":
        http_response(writer, "200 OK", b"ok\n")
    else:
        http_response(writer, "404 Not Found", b"Not found\n")

    await writer.drain()
    writer.close()
    await writer.wait_closed()


async def amain() -> None:
    parser = argparse.ArgumentParser(description="Minimal local OCPP 1.6J CSMS demo")
    parser.add_argument("--host", default="0.0.0.0", help="Bind address")
    parser.add_argument("--port", type=int, default=9000, help="Bind port")
    parser.add_argument("--heartbeat", type=int, default=30, help="BootNotification heartbeat interval")
    args = parser.parse_args()

    global HEARTBEAT_INTERVAL
    HEARTBEAT_INTERVAL = args.heartbeat

    server = await asyncio.start_server(handle_http_client, args.host, args.port)
    print(f"Local OCPP CSMS listening on {args.host}:{args.port}")
    print(f"Dashboard: http://{local_ip_hint()}:{args.port}/")
    print(f"Charger URL: ws://{local_ip_hint()}:{args.port}/ocpp")

    async with server:
        await server.serve_forever()


if __name__ == "__main__":
    try:
        asyncio.run(amain())
    except KeyboardInterrupt:
        pass
