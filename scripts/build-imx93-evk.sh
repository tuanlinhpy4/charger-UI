#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -gt 2 ]; then
    echo "Usage: $0 [/path/to/environment-setup-*] [build-dir]" >&2
    echo "       $0 [build-dir]  # when ./sysroot is present" >&2
    exit 2
fi

sdk_env="${1:-}"
build_dir="${2:-build-imx93}"
use_local_sysroot=0

if [ -n "$sdk_env" ] && [ -f "$sdk_env" ]; then
    # shellcheck disable=SC1090
    source "$sdk_env"
elif [ "$#" -eq 1 ] && [ -d "./sysroot/usr" ]; then
    build_dir="$1"
    export SDKTARGETSYSROOT="$PWD/sysroot"
    use_local_sysroot=1
elif [ -n "$sdk_env" ]; then
    if [ ! -f "$sdk_env" ]; then
        echo "SDK environment file not found: $sdk_env" >&2
        exit 1
    fi
elif [ -d "./sysroot/usr" ]; then
    export SDKTARGETSYSROOT="$PWD/sysroot"
    use_local_sysroot=1
else
    echo "No SDK environment file was provided and ./sysroot was not found." >&2
    exit 1
fi

cmake_args=(
    -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/nxp-imx93-yocto-sdk.cmake
    -DCMAKE_BUILD_TYPE=Release
)

if [ "$use_local_sysroot" -eq 1 ]; then
    cmake_args+=(-DEV_CHARGER_USE_SYSROOT_QT=ON)
fi

cmake -S . -B "$build_dir" \
    "${cmake_args[@]}"

cmake --build "$build_dir" --parallel

echo
echo "Built: $build_dir/ev_charger_ui"
echo "Target sysroot: ${SDKTARGETSYSROOT:-${OECORE_TARGET_SYSROOT:-unknown}}"
