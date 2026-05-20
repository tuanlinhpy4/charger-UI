# GETECH EV Charging Station UI

Giao diện HMI cho trạm sạc xe điện GETECH, phát triển trên nền **NXP EasyEVSE Development Platform** (i.MX 93, Linux OS, EVerest / ISO 15118).

Brand: **GETECH** — thay thế VinFast ban đầu.

## Tính năng đầy đủ

### Các màn hình (8 màn hình)

| Màn hình | File | Mô tả |
|---|---|---|
| **Trang chủ** | `screens/HomeScreen.qml` | Tổng quan trạm, 2 port card, bảng giá, system status |
| **Chọn cổng sạc** | `screens/PortSelectionScreen.qml` | So sánh Port A / Port B, chọn loại connector |
| **Xác thực** | `screens/AuthScreen.qml` | 4 phương thức: App QR, NFC/RFID, PIN, Plug & Charge |
| **Đang sạc** | `screens/ChargingScreen.qml` | Màn hình sạc chính, gauge, chart, real-time stats |
| **Chi tiết phiên** | `screens/SessionDetailsScreen.qml` | Báo cáo năng lượng, metrology, chi phí |
| **Thanh toán** | `screens/PaymentScreen.qml` | 5 phương thức thanh toán, hóa đơn |
| **Lịch sử** | `screens/HistoryScreen.qml` | Bảng lịch sử phiên sạc, filter, tổng kết |
| **Cài đặt** | `screens/SettingsScreen.qml` | 7 phần: Display, Network, Charging, Security, OCPP, Tools, Info |

### Components (tái sử dụng)

| Component | File | Mô tả |
|---|---|---|
| **Theme** | `components/Theme.qml` | Singleton: màu sắc, font, spacing, helper |
| **TopBar** | `components/TopBar.qml` | Thanh điều hướng trên cùng |
| **PortCard** | `components/PortCard.qml` | Card cổng sạc đa trạng thái |
| **Dialog** | `components/Dialog.qml` | Dialog popup đa năng |

## Kiến trúc

```
┌──────────────────────────────────────────────────┐
│  QML Screens (main.qml + 8 screens)             │
├──────────────────────────────────────────────────┤
│  QML Components (Theme singleton + 3 components) │
├──────────────────────────────────────────────────┤
│  ChargerBackend (C++)                            │
│  ├─ ChargerPort (A, B)                          │
│  │   ├─ State machine: Available/Charging/      │
│  │   │   Finished/Faulted/Locked/AwaitingAuth  │
│  │   ├─ Simulated charging curve (taper >80%)   │
│  │   ├─ Session cost calculation               │
│  │   └─ Authentication methods                 │
│  ├─ OCPPManager (OCPP 1.6J client/libocpp)     │
│  └─ ChargerBackend (station info + clock)        │
├──────────────────────────────────────────────────┤
│  Qt Property System (signal/slot)                │
└──────────────────────────────────────────────────┘
```

## Tính năng kỹ thuật NXP EasyEVSE được mô phỏng

- **ISO 15118-2**: Plug & Charge, SECC communication
- **SAE J1772**: Control Pilot, PWM signaling
- **CCS2 / CHAdeMO / Type 2**: connector types
- **ISO 15118-20**: bi-directional charging support
- **Wi-Fi 6 (IW612)**: cloud connectivity
- **EdgeLock SE050**: secure element, encryption
- **PN7160 NFC**: tap-to-authenticate
- **KM35x Metrology**: pre-certified energy metering
- **OCPP 1.6J**: charge point protocol
- **GFCI + Relay**: safety functions
- **DY1212W-4856**: 12.1" LCD display

## Cấu trúc project

```
ev_charger_ui/
├── CMakeLists.txt           Build config (Qt5 + Qt6)
├── resources.qrc            Bundled QML resources
├── src/
│   ├── main.cpp             Entry point, QML registration
│   ├── chargerbackend.h     C++ header
│   └── chargerbackend.cpp   Full implementation
└── qml/
    ├── main.qml             Root + StackView navigation
    ├── components/
    │   ├── Theme.qml        Singleton theme
    │   ├── TopBar.qml       Navigation bar
    │   ├── PortCard.qml     Reusable port card
    │   └── Dialog.qml       Dialog component
    └── screens/
        ├── HomeScreen.qml
        ├── PortSelectionScreen.qml
        ├── AuthScreen.qml
        ├── ChargingScreen.qml
        ├── SessionDetailsScreen.qml
        ├── PaymentScreen.qml
        ├── HistoryScreen.qml
        └── SettingsScreen.qml
```

## Build trên Desktop (Ubuntu)

```bash
sudo apt install qtbase5-dev qtdeclarative5-dev qtquickcontrols2-5-dev cmake g++

mkdir build && cd build
cmake ..
make -j$(nproc)
./ev_charger_ui
```

## Build cho Embedded (NXP MCIMX93-EVK / i.MX93)

Board `MCIMX93-EVK` chạy i.MX93 Cortex-A55, nên app Qt/QML này cần được build bằng SDK/sysroot AArch64 của đúng BSP đang chạy trên board. Không dùng sysroot desktop Ubuntu và không dùng SDK `cortexa72`.

### 1. Tạo image/SDK Yocto cho board

Theo NXP i.MX93 EVK BSP flow:

```bash
repo init -u https://github.com/nxp-imx/imx-manifest \
  -b imx-linux-styhead \
  -m imx-6.12.3-1.0.0.xml
repo sync

DISTRO=fsl-imx-xwayland MACHINE=imx93-11x11-lpddr4x-evk \
  source imx-setup-release.sh -b build-xwayland
```

Thêm Qt runtime/dev packages vào image hoặc SDK. Với Qt5:

```bash
IMAGE_INSTALL:append = " qtbase qtdeclarative qtquickcontrols2"
TOOLCHAIN_TARGET_TASK:append = " qtbase-dev qtdeclarative-dev qtquickcontrols2-dev"
```

Build image và SDK:

```bash
bitbake imx-image-full
bitbake imx-image-full -c populate_sdk
```

Sau đó cài SDK `.sh` sinh ra trong `tmp/deploy/sdk/`, ví dụ vào `/opt/fsl-imx-xwayland/`.

### 2. Cross-build app bằng sysroot của SDK

Project đã có toolchain file tại `cmake/toolchains/nxp-imx93-yocto-sdk.cmake`. Nếu đã cài full Yocto SDK, cách build ngắn nhất:

```bash
./scripts/build-imx93-evk.sh \
  /opt/fsl-imx-xwayland/6.12.3-1.0.0/environment-setup-armv8a-poky-linux
```

Nếu đã copy target sysroot FRDM vào `./sysroot_frdm` hoặc EVK vào `./sysroot_evk`, script cũng tự nhận. Có thể ép sysroot bằng `EV_CHARGER_SYSROOT=/path/to/sysroot`:

```bash
./scripts/build-imx93-evk.sh
```

Với local `./sysroot_evk`, máy build vẫn cần host tools chạy được trên Ubuntu:

```bash
sudo apt install g++-aarch64-linux-gnu \
  qt6-base-dev-tools qt6-declarative-dev-tools \
  qt6-base-dev qt6-declarative-dev pkg-config
```

Lưu ý: compiler nằm trong `sysroot_evk/usr/bin` của target là ARM64 binary và không chạy được trên host x86_64. Cấu hình local `./sysroot_evk` của project dùng `pkg-config` từ sysroot để link Qt 6.5 target libs, đồng thời dùng `moc/rcc` host để generate code. Full Yocto SDK vẫn là lựa chọn chuẩn nhất cho release.

Hoặc chạy thủ công:

```bash
source /opt/fsl-imx-xwayland/6.12.3-1.0.0/environment-setup-armv8a-poky-linux
cmake -S . -B build-imx93_evk \
  -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/nxp-imx93-yocto-sdk.cmake \
  -DYOCTO_TARGET_SYSROOT="$PWD/sysroot_frdm" \
  -DEV_CHARGER_ENABLE_LIBOCPP=ON \
  -DCMAKE_BUILD_TYPE=Release
cmake --build build-imx93_evk --parallel
```

Kiểm tra binary đúng AArch64:

```bash
file build-imx93_evk/ev_charger_ui
```

Kết quả mong đợi có dạng `ELF 64-bit ... ARM aarch64`.

### 3. Chạy OCPP cloud demo trên máy PC trong LAN

Server demo không cần package ngoài, nhận WebSocket OCPP 1.6J và mở dashboard HTTP:

```bash
python3 cloud/ocpp_local_server.py --host 0.0.0.0 --port 9000
```

Mở dashboard:

```text
http://<pc-ip>:9000/
```

Trên board, trỏ app về PC trong LAN:

```bash
export EV_CHARGER_CSMS_URL=ws://<pc-ip>:9000/ocpp
export EV_CHARGER_CHARGE_BOX_ID=GT-EVSE-A001
```

`libocpp` sẽ tự nối thành path `/ocpp/GT-EVSE-A001`.

### 4. Chạy trên board

Nên stage bằng CMake install để copy cả binary, thư viện runtime Boost/libwebsockets và dữ liệu `share/everest/modules/OCPP`:

```bash
cmake --install build-imx93_evk --prefix /tmp/ev_charger_stage
scp -r /tmp/ev_charger_stage/* root@<board-ip>:/usr/local/
```

Nếu image có Weston/Wayland:

```bash
EV_CHARGER_CSMS_URL=ws://<pc-ip>:9000/ocpp \
QT_QPA_PLATFORM=wayland /usr/local/bin/ev_charger_ui
```

Nếu chạy fullscreen trực tiếp qua DRM/KMS:

```bash
EV_CHARGER_CSMS_URL=ws://<pc-ip>:9000/ocpp \
QT_QPA_PLATFORM=eglfs /usr/local/bin/ev_charger_ui
```

Nếu thiếu QML module trên target, cài thêm runtime tương ứng vào image/rootfs:

```bash
qtdeclarative-qmlplugins qtquickcontrols2
```

## Mở rộng

- Thay simulation bằng **CAN FD data thật** (qua SocketCAN)
- Kết nối **NFC PN7160** qua I2C
- Kết nối **KM35x metrology** qua UART
- Thêm **MQTT telemetry** cho cloud monitoring
- Tích hợp **EVerest** framework thật
- Thêm chế độ **bi-directional / V2G** (ISO 15118-20)
