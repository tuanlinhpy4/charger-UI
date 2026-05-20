#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -gt 2 ]; then
    echo "Usage: $0 [/path/to/environment-setup-*] [build-dir]" >&2
    echo "       $0 [build-dir]  # when ./sysroot_evk is present" >&2
    exit 2
fi

sdk_env="${1:-}"
build_dir="${2:-build-imx93_evk}"
if [ -n "${EV_CHARGER_SYSROOT:-}" ]; then
    local_sysroot="$EV_CHARGER_SYSROOT"
elif [ -d "$PWD/sysroot_frdm/usr" ]; then
    local_sysroot="$PWD/sysroot_frdm"
else
    local_sysroot="$PWD/sysroot_evk"
fi
use_local_sysroot=0

if [ -n "$sdk_env" ] && [ -f "$sdk_env" ]; then
    # shellcheck disable=SC1090
    source "$sdk_env"
elif [ "$#" -eq 1 ] && [ -d "$local_sysroot/usr" ]; then
    build_dir="$1"
    export SDKTARGETSYSROOT="$local_sysroot"
    use_local_sysroot=1
elif [ -n "$sdk_env" ]; then
    if [ ! -f "$sdk_env" ]; then
        echo "SDK environment file not found: $sdk_env" >&2
        exit 1
    fi
elif [ -d "$local_sysroot/usr" ]; then
    export SDKTARGETSYSROOT="$local_sysroot"
    use_local_sysroot=1
else
    echo "No SDK environment file was provided and $local_sysroot was not found." >&2
    exit 1
fi

cmake_args=(
    -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/nxp-imx93-yocto-sdk.cmake
    -DCMAKE_BUILD_TYPE=Release
)

if [ "$use_local_sysroot" -eq 1 ]; then
    cmake_args+=(
        -DYOCTO_TARGET_SYSROOT="$SDKTARGETSYSROOT"
        -DEV_CHARGER_USE_SYSROOT_QT=ON
    )
fi

if [ -f "$build_dir/CMakeCache.txt" ]; then
    cached_sysroot="$(grep -E '^CMAKE_SYSROOT:PATH=' "$build_dir/CMakeCache.txt" | cut -d= -f2- || true)"
    if [ "$use_local_sysroot" -eq 1 ] && [ "$cached_sysroot" != "$SDKTARGETSYSROOT" ]; then
        echo "Refreshing stale CMake cache in $build_dir"
        rm -f "$build_dir/CMakeCache.txt"
        rm -rf "$build_dir/CMakeFiles"
    fi
fi

cmake -S . -B "$build_dir" \
    "${cmake_args[@]}"

cmake --build "$build_dir" --parallel

echo
echo "Built: $build_dir/ev_charger_ui"
echo "Target sysroot: ${SDKTARGETSYSROOT:-${OECORE_TARGET_SYSROOT:-unknown}}"
