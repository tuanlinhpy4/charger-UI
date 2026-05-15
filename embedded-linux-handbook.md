# Giáo Trình Thực Hành Embedded Linux Development

> **Tác giả:** Tổng hợp từ Bootlin - Embedded Linux System Development Training  
> **Bản quyền:** Creative Commons BY-SA 3.0  
> **Cập nhật:** 2026

---

## Mục lục

- [Chương 1: Giới thiệu Embedded Linux](#chương-1-giới-thiệu-embedded-linux)
- [Chương 2: Môi trường phát triển](#chương-2-môi-trường-phát-triển)
- [Chương 3: Cross-compilation Toolchain](#chương-3-cross-compilation-toolchain)
- [Chương 4: Bootloader](#chương-4-bootloader)
- [Chương 5: Linux Kernel](#chương-5-linux-kernel)
- [Chương 6: Root Filesystem](#chương-6-root-filesystem)
- [Chương 7: BusyBox - Tạo hệ thống tối giản](#chương-7-busybox---tạo-hệ-thống-tối-giản)
- [Chương 8: Device Tree](#chương-8-device-tree)
- [Chương 9: Filesystem](#chương-9-filesystem)
- [Chương 10: Embedded Build Systems](#chương-10-embedded-build-systems)
- [Chương 11: Phát triển Ứng dụng](#chương-11-phát-triển-ứng-dụng)
- [Chương 12: Debugging](#chương-12-debugging)
- [Chương 13: Tracing và Profiling](#chương-13-tracing-và-profiling)

---

## Chương 1: Giới thiệu Embedded Linux

### Mục tiêu học tập
- Hiểu khái niệm Embedded Linux
- Nắm được ưu điểm của Linux trong embedded
- Phân biệt các thành phần trong hệ thống Embedded Linux

### 1.1 Embedded Linux là gì?

**Embedded Linux** là việc sử dụng Linux kernel và các thành phần open-source để xây dựng hệ thống nhúng. Khác với máy tính thông thường, hệ thống embedded:
- Chạy một chức năng cố định (không phải máy tính đa năng)
- Thường có tài nguyên hạn chế (RAM, CPU, storage)
- Cần độ tin cậy cao, boot nhanh
- Thường không có hoặc có giao diện tối giản

**Ví dụ thực tế:**
- Router WiFi (OpenWrt)
- Smart TV (Android TV)
- Ô tô (hệ thống infotainment, ECU)
- Robot công nghiệp
- Thiết bị IoT
- Máy ATM
- SpaceX Starlink satellites, Mars Ingenuity Helicopter

### 1.2 Tại sao chọn Embedded Linux?

#### Lợi thế

**1. Tiết kiệm chi phí**
- Không mất phí royalty theo sản phẩm
- Công cụ phát triển miễn phí (gcc, gdb, Linux...)
- Tận dụng phần cứng giá rẻ

**2. Tái sử dụng cao**
- Hàng nghìn driver có sẵn
- Hỗ trợ hầu hết các giao thức mạng
- Không cần viết lại từ đầu

**3. Kiểm soát hoàn toàn**
- Toàn quyền với source code
- Cập nhật khi nào bạn muốn
- Không phụ thuộc vào một vendor

**4. Bảo mật**
- Kiểm tra source code mọi thành phần
- Phát hiện lỗ hổng nhanh chóng (cộng đồng lớn)
- Cập nhật bảo mật kịp thời

### 1.3 So sánh Desktop Linux vs Embedded Linux

| Khía cạnh | Desktop Linux | Embedded Linux |
|-----------|---------------|----------------|
| **RAM** | 4-32 GB | 8-512 MB |
| **Storage** | 256 GB - TB | 4 MB - 32 GB |
| **Boot time** | 10-60 giây | 1-5 giây |
| **Init system** | systemd | BusyBox init, systemd |
| **C library** | glibc | glibc, uClibc, musl |
| **Package manager** | apt, dnf | Thường không có |
| **Display** | X11, Wayland | Framebuffer, DRM, EGL |

### 1.4 Các thành phần trong Embedded Linux System

```
┌────────────────────────────────────────────────────┐
│                    USER SPACE                       │
│  ┌──────────┐  ┌──────────┐  ┌──────────────────┐ │
│  │ Apps     │  │ Libraries │  │ C Standard Lib   │ │
│  └──────────┘  └──────────┘  └──────────────────┘ │
├────────────────────────────────────────────────────┤
│                    KERNEL SPACE                     │
│  ┌──────────┐  ┌──────────┐  ┌──────────────────┐ │
│  │ Drivers  │  │ Subsystem│  │ Device Drivers   │ │
│  │ (GPIO,   │  │ (VFS,     │  │ (USB, I2C, SPI,  │ │
│  │  I2C...) │  │  Net...)  │  │  Network...)    │ │
│  └──────────┘  └──────────┘  └──────────────────┘ │
├────────────────────────────────────────────────────┤
│                    BOOTLOADER                       │
│              (U-Boot, Barebox, GRUB)                │
├────────────────────────────────────────────────────┤
│                    FIRMWARE                         │
│           (Boot ROM → Bootloader)                   │
└────────────────────────────────────────────────────┘
```

### 1.5 Phần cứng phổ biến cho học tập

#### BeagleBone Black
```
CPU: ARM Cortex-A8 1GHz
RAM: 512 MB DDR3
Storage: 4 GB eMMC + microSD
Giá: ~$55
Ưu điểm: Nhiều GPIO, community lớn, documentation tốt
```

#### Raspberry Pi 4
```
CPU: ARM Cortex-A72 1.5GHz (64-bit)
RAM: 1-8 GB LPDDR4
Storage: microSD + USB
Giá: ~$35-75
Ưu điểm: Phổ biến nhất, nhiều accessories
```

#### STM32MP157 (Discovery Kit)
```
CPU: Dual ARM Cortex-A7 + Cortex-M4
RAM: 512 MB DDR3L
Giá: ~$20-50
Ưu điểm: Hỗ trợ real-time (Cortex-M4), dùng trong công nghiệp
```

### 1.6 Kiến trúc CPU được hỗ trợ

| Kiến trúc | Tuple | Ví dụ thiết bị |
|-----------|-------|----------------|
| ARM 32-bit | `arm-linux-gnueabihf` | BeagleBone, Raspberry Pi 3 |
| ARM 64-bit | `aarch64-linux-gnu` | Raspberry Pi 4, BeaglePlay |
| RISC-V | `riscv64-linux-gnu` | HiFive, StarFive |
| MIPS | `mips-linux-gnu` | Router WiFi |
| x86 | `x86_64-linux-gnu` | Intel NUC, PC engines |

### Bài tập Chương 1

**Bài 1.1:** Xác định kiến trúc CPU của máy tính bạn đang dùng:
```bash
# Linux
uname -m
cat /proc/cpuinfo | grep "model name" | head -1

# Hoặc
dpkg --print-architecture
```

**Bài 1.2:** Liệt kê các thiết bị embedded Linux bạn đang sử dụng trong cuộc sống hàng ngày (router, TV box, camera...).

---

## Chương 2: Môi trường phát triển

### Mục tiêu học tập
- Thiết lập môi trường phát triển trên Linux host
- Kết nối host với target board
- Sử dụng các công cụ serial terminal

### 2.1 Chuẩn bị Host System

**Khuyến nghị:** Sử dụng Ubuntu 22.04 LTS hoặc Debian 12 trở lên.

#### Cài đặt các gói cần thiết

```bash
# Cập nhật hệ thống
sudo apt update && sudo apt upgrade -y

# Các công cụ cơ bản
sudo apt install -y \
    build-essential \
    git \
    wget \
    curl \
    rsync \
    tar \
    gzip \
    bzip2 \
    xz-utils \
    zlib1g-dev \
    libncurses-dev \
    libssl-dev \
    python3 \
    python3-pip \
    ccache

# Công cụ serial terminal
sudo apt install -y \
    picocom \
    minicom \
    screen

# Công cụ mạng
sudo apt install -y \
    tftpd-hpa \
    nfs-kernel-server \
    openssh-server
```

### 2.2 Kết nối Serial Console

Serial console là cách chính để giao tiếp với embedded board khi không có giao diện đồ họa.

#### Tìm cổng Serial

```bash
# Liệt kê các thiết bị USB
ls -la /dev/ttyUSB*
ls -la /dev/ttyACM*
lsusb

# Hoặc theo dõi khi cắm thiết bị
dmesg | tail -20
```

Kết quả thường là `/dev/ttyUSB0` hoặc `/dev/ttyACM0`.

#### Sử dụng picocom (khuyến nghị)

```bash
# Cài đặt
sudo apt install picocom

# Kết nối (thường 115200 baud cho BeagleBone)
picocom -b 115200 /dev/ttyUSB0

# Thoát: Ctrl+A, Ctrl+X
```

**Tham số kết nối phổ biến:**
| Board | Baud rate |
|-------|-----------|
| BeagleBone Black | 115200 |
| Raspberry Pi | 115200 |
| STM32 | 115200 hoặc 9600 |
| BeaglePlay | 115200 |

#### Sử dụng minicom

```bash
# Cấu hình
sudo minicom -s

# Hoặc chạy trực tiếp
sudo minicom -D /dev/ttyUSB0 -b 115200
```

#### Sử dụng screen

```bash
screen /dev/ttyUSB0 115200

# Thoát: Ctrl+A, K, Y
```

#### Sử dụng tio (nhanh và nhẹ)

```bash
# Cài đặt
sudo apt install tio

# Kết nối
tio /dev/ttyUSB0 -b 115200
```

### 2.3 Cấu hình mạng để truy cập Board

#### Thiết lập IP tĩnh cho card mạng

```bash
# Xem các interface
ip link show
ip addr show

# Cấu hình static IP cho card mạng kết nối với board
sudo ip addr add 192.168.1.1/24 dev eth0

# Hoặc dùng NetworkManager
nmcli con add con-name "board-net" ifname eth0 type ethernet ip4 192.168.1.1/24
```

#### Ping test

```bash
# Từ host
ping 192.168.1.100

# Từ board (sau khi có Linux chạy)
ping 192.168.1.1
```

### 2.4 Thiết lập TFTP Server

TFTP dùng để tải kernel, dtb qua mạng từ host.

```bash
# Cài đặt
sudo apt install tftpd-hpa

# Cấu hình /etc/default/tftpd-hpa
cat > /etc/default/tftpd-hpa << 'EOF'
TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/srv/tftp"
TFTP_ADDRESS=":69"
TFTP_OPTIONS="--secure --verbose"
EOF

# Tạo thư mục và phân quyền
sudo mkdir -p /srv/tftp
sudo chmod 777 /srv/tftp

# Khởi động lại service
sudo systemctl restart tftpd-hpa

# Copy file để test
echo "test" | sudo tee /srv/tftp/test.txt
```

### 2.5 Thiết lập NFS Server

NFS cho phép mount root filesystem từ host qua mạng.

```bash
# Cài đặt
sudo apt install nfs-kernel-server

# Cấu hình /etc/exports
cat >> /etc/exports << 'EOF'
/nfs/root  *(rw,sync,no_subtree_check,no_root_squash)
EOF

# Tạo thư mục
sudo mkdir -p /nfs/root

# Export
sudo exportfs -ra

# Kiểm tra
sudo exportfs -v
```

### Bài tập Chương 2

**Bài 2.1:** Kết nối serial console với một embedded board (hoặc mô phỏng với `socat` nếu không có hardware):
```bash
# Mô phỏng serial port
socat -d -d PTY,raw,echo=0 PTY,raw,echo=0

# Output sẽ hiển thị 2 pseudo-TTY, dùng một cái cho picocom
```

**Bài 2.2:** Thiết lập TFTP server và tạo file test, kiểm tra từ board:
```bash
# Trên host
ls /srv/tftp/

# Trên board (nếu có)
tftp -g -r test.txt <host-ip>
```

---

## Chương 3: Cross-compilation Toolchain

### Mục tiêu học tập
- Hiểu kiến trúc cross-compilation
- Sử dụng pre-built toolchain
- Xây dựng toolchain tùy chỉnh với Crosstool-NG
- Phân biệt các C library

### 3.1 Tại sao cần Cross-compilation?

Embedded board thường có CPU yếu (ARM, MIPS, RISC-V) và không đủ tài nguyên để biên dịch phần mềm. Do đó, ta biên dịch trên máy tính mạnh (host) rồi copy sang board (target).

```
┌──────────────────────┐         ┌──────────────────────┐
│      HOST (x86_64)   │         │    TARGET (ARM)      │
│                      │         │                      │
│   ┌──────────────┐   │   SCP    │   ┌──────────────┐   │
│   │ arm-gcc      │────┼─────────┼──▶│  myapp       │   │
│   │ (chạy trên   │   │  binary  │   │  (chạy trên  │   │
│   │  x86_64)     │   │         │   │   ARM)        │   │
│   └──────────────┘   │         │   └──────────────┘   │
└──────────────────────┘         └──────────────────────┘
```

### 3.2 Các thành phần của Toolchain

```
┌────────────────────────────────────────────────┐
│              CROSS-COMPILER TOOLCHAIN           │
├────────────────────────────────────────────────┤
│  Binutils: as, ld, ar, objdump, readelf, strip │
├────────────────────────────────────────────────┤
│  GCC: C/C++/Ada/Fortran compiler               │
├────────────────────────────────────────────────┤
│  C Library: glibc / uClibc-ng / musl          │
├────────────────────────────────────────────────┤
│  Kernel Headers: System call interface         │
└────────────────────────────────────────────────┘
```

#### Binutils

| Công cụ | Chức năng |
|----------|-----------|
| `as` | Assembler - chuyển assembly thành object |
| `ld` | Linker - ghép object files thành executable |
| `ar` | Tạo và quản lý archive (.a) |
| `objdump` | Hiển thị thông tin binary |
| `readelf` | Phân tích ELF format |
| `nm` | Liệt kê symbols trong binary |
| `strip` | Loại bỏ debug symbols, giảm kích thước |
| `objcopy` | Chuyển đổi object file formats |

#### GCC (GNU Compiler Collection)

Hỗ trợ nhiều ngôn ngữ: C, C++, Objective-C, Fortran, Ada, Go, Java...

```bash
# Ví dụ biên dịch
arm-linux-gnueabihf-gcc -o myapp main.c

# Các cờ thường dùng
arm-linux-gnueabihf-gcc \
    -Wall \          # Bật tất cả warnings
    -O2 \            # Tối ưu hóa
    -g \             # Debug symbols
    -march=armv7-a \ # Target architecture
    -mtune=cortex-a7 # CPU specific tuning
```

### 3.3 C Library Options

#### So sánh

| Library | Kích thước (ARM) | License | Đặc điểm |
|---------|------------------|---------|-----------|
| **glibc** | ~2 MB | LGPL | Đầy đủ, chuẩn, nặng |
| **uClibc-ng** | ~700 KB | LGPL | Nhẹ, cấu hình được, no-MMU |
| **musl** | ~750 KB | MIT | Nhẹ, nhanh, static linking tốt |

#### Khi nào dùng gì?

```
glibc  → Khi cần đầy đủ tính năng, debug tốt, production
uClibc → Khi RAM < 64 MB, cần giảm kích thước
musl   → Khi cần static binary nhỏ, hoặc dùng Alpine Linux
```

### 3.4 Sử dụng Pre-built Toolchain

#### Từ Bootlin (khuyến nghị cho người mới)

```bash
# Download toolchain cho ARM Cortex-A (hard-float)
wget https://toolchains.bootlin.com/downloads \
     /releases/2024.02-1/arm cortex-a9--glibc--stable.tar.bz2

# Extract
tar xjf arm-cortexa9--glibc--stable.tar.bz2 -C /opt

# Sử dụng
export PATH="/opt/arm-cortexa9--glibc--stable/bin:$PATH"
arm-linux-gnueabihf-gcc --version
```

#### Từ ARM GNU Toolchain

```bash
# Download ARM GNU Toolchain (officially from ARM)
wget https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1 \
     /binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz

tar xf arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz \
     -C /opt

export PATH="/opt/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-linux-gnueabihf/bin:$PATH"
arm-none-linux-gnueabihf-gcc --version
```

### 3.5 Xây dựng Toolchain với Crosstool-NG

#### Cài đặt Crosstool-NG

```bash
# Clone repository
git clone https://github.com/crosstool-ng/crosstool-ng.git
cd crosstool-ng

# Build và cài đặt
./bootstrap && ./configure --prefix=/opt/ctng && make -j$(nproc)
sudo make install

# Thêm vào PATH
export PATH="/opt/ctng/bin:$PATH"
```

#### Cấu hình với menuconfig

```bash
ct-ng menuconfig
```

**Các bước quan trọng trong menuconfig:**

```
Paths and misc options
  → Local tarballs directory  : /opt/src
  → Build tuples in a folder   : Yes

Target options
  → Architecture                : arm
  → Bitness                     : 32-bit
  → Emit assembly for CPU       : cortex-a7
  → Use specific FPU            : vfpv3-d16
  → Float ABI                   : hard

Toolchain options
  → Tuple's vendor string       : cortexa9
  → Tuple's alias               : arm-linux-gnueabihf

Operating System
  → Target OS                   : linux

Binary utilities
  → Binutils version            : 2.41

C compiler
  → gcc version                : 13.2.0
  → C++                        : YES
  → Enable LTO                 : NO

C library
  → C library                  : glibc
  → glibc version             : 2.38
```

#### Build

```bash
# Tải source và build
ct-ng build

# Quá trình mất 15-30 phút
# Output trong ~/.local/arm-cortexa9-linux-gnueabihf/
```

### 3.6 Sử dụng sysroot

Sysroot là thư mục chứa các thư viện và header của target system.

```
/opt/toolchain/
├── bin/
│   └── arm-linux-gnueabihf-gcc
└── arm-cortexa9-linux-gnueabihf/
    └── sysroot/
        ├── usr/
        │   ├── include/        # Headers
        │   └── lib/           # Libraries (.so, .a)
        └── lib/               # System libraries
```

#### Cross-compile với sysroot

```bash
# Khai báo sysroot
SYSROOT=/opt/rootfs
CC="arm-linux-gnueabihf-gcc"
CFLAGS="--sysroot=$SYSROOT -I$SYSROOT/usr/include"
LDFLAGS="-L$SYSROOT/usr/lib --sysroot=$SYSROOT"

# Compile
$CC $CFLAGS -o myapp main.c $LDFLAGS
```

### 3.7 Ví dụ: Compile "Hello World" cho ARM

**Trên host:**

```bash
# Tạo thư mục project
mkdir -p ~/embedded-project/hello-world
cd ~/embedded-project/hello-world

# Tạo file nguồn
cat > main.c << 'EOF'
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    printf("Hello from Embedded Linux!\n");
    printf("Running on: %s\n", 
           #ifdef __ARM_ARCH
               "ARM processor"
           #else
               "Unknown processor"
           #endif
    );
    printf("Compiled with: %s\n", __VERSION__);
    return 0;
}
EOF

# Compile cho ARM (giả sử đã cài toolchain)
arm-linux-gnueabihf-gcc -o hello_arm main.c

# Kiểm tra
file hello_arm
# Output: hello_arm: ELF 32-bit LSB executable, ARM, EABI5 version...

# Strip để giảm kích thước
arm-linux-gnueabihf-strip hello_arm

# Copy sang board
scp hello_arm root@192.168.1.100:/tmp/

# Chạy trên board
# ./hello_arm
```

### 3.8 Compile thư viện bên thứ ba

#### Ví dụ: Compile libmnl (cho Netfilter)

```bash
# Download source
git clone https://git.netfilter.org/libmnl/
cd libmnl

# Configure cho ARM
./autogen.sh
./configure \
    --host=arm-linux-gnueabihf \
    --prefix=/opt/rootfs/usr \
    --enable-static=yes \
    --enable-shared=yes

# Build
make -j$(nproc)

# Install vào sysroot
make install DESTDIR=/opt/rootfs

# Kiểm tra
ls /opt/rootfs/usr/lib/
ls /opt/rootfs/usr/include/
```

### Bài tập Chương 3

**Bài 3.1:** Cài đặt pre-built toolchain từ Bootlin và compile chương trình "Hello World" cho ARM.

**Bài 3.2:** So sánh kích thước binary khi compile với các options khác nhau:

```bash
# No optimization
arm-linux-gnueabihf-gcc -o hello_no_opt main.c
ls -lh hello_no_opt

# Optimization -Os (size)
arm-linux-gnueabihf-gcc -Os -o hello_size main.c
ls -lh hello_size

# Optimization -O2 (speed)
arm-linux-gnueabihf-gcc -O2 -o hello_speed main.c
ls -lh hello_speed

# Static linking (không cần libc trên target)
arm-linux-gnueabihf-gcc -static -o hello_static main.c
ls -lh hello_static
```

---

## Chương 4: Bootloader

### Mục tiêu học tập
- Hiểu boot sequence của embedded system
- Cấu hình và build U-Boot
- Sử dụng U-Boot commands
- Thiết lập boot qua network

### 4.1 Boot Sequence tổng quát

```
┌─────────────────────────────────────────────────────────────┐
│                     BOOT SEQUENCE                           │
├─────────────────────────────────────────────────────────────┤
│  1. Boot ROM (on-chip)     - Nằm trong SoC, không đổi      │
│     ↓                       được                           │
│  2. Primary Bootloader    - Tải từ storage hoặc network   │
│     ↓                                                     │
│  3. Secondary Program     - SPL (U-Boot SPL)              │
│     Loader (SPL)           - Load main U-Boot              │
│     ↓                                                     │
│  4. U-Boot                - Hỗ trợ nhiều boot options     │
│     ↓                                                     │
│  5. Kernel                - Linux kernel                  │
│     ↓                                                     │
│  6. Root Filesystem       - BusyBox/systemd + apps        │
└─────────────────────────────────────────────────────────────┘
```

### 4.2 Giới thiệu U-Boot

**U-Boot** (Das U-Boot) là bootloader phổ biến nhất cho embedded systems.

**Đặc điểm:**
- Hỗ trợ nhiều kiến trúc: ARM, ARM64, RISC-V, PowerPC, MIPS
- Có kconfig để cấu hình
- Network support (TFTP, DHCP, NFS)
- Shell commands phong phú
- GPLv2 license

**Nguồn:**
```
https://gitlab.denx.de/u-boot/u-boot
```

### 4.3 Boot Sequence cho ARM platforms

#### BeagleBone Black (AM335x)

```
ROM → MLO (SPL) → u-boot.img (main) → zImage + DTB
```

**Partition layout trên eMMC/SD:**
| Partition | Offset | Contents |
|-----------|--------|----------|
| MLO | 0x0 | First-stage bootloader |
| u-boot.img | 0x20000 | Main U-Boot |
| (empty) | | Reserved for environment |
| boot | | Kernel + DTB |

#### STM32MP1

```
ROM → TF-A BL2 → OP-TEE (optional) → U-Boot SPL → U-Boot
```

### 4.4 Cấu hình U-Boot

#### Tìm defconfig phù hợp

```bash
git clone https://gitlab.denx.de/u-boot/u-boot.git
cd u-boot

# Tìm board configs
ls configs/*_defconfig | head -30
ls configs/*beaglebone* 2>/dev/null
ls configs/*stm32* 2>/dev/null
```

#### Cấu hình cho BeagleBone Black

```bash
make am335x_boneblack_defconfig
# hoặc
make am335x_evm_defconfig

# Tùy chỉnh thêm
make menuconfig
```

#### Cấu hình cho STM32MP157

```bash
make stm32mp15_trusted_defconfig
make menuconfig
```

### 4.5 Build U-Boot

```bash
# Chuẩn bị environment
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
export PATH="/opt/toolchain/bin:$PATH"

# Configure
make am335x_boneblack_defconfig

# Build
make -j$(nproc)

# Output files:
# spl/u-boot-spl.bin     → MLO (First stage)
# u-boot.img             → Main bootloader
# u-boot.dtb             → Device tree blob
```

### 4.6 U-Boot Commands

Khi boot vào U-Boot (serial console), bạn có thể dùng các commands:

#### Thông tin hệ thống

```bash
# Xem thông tin board
bdinfo

# Xem và set environment variables
printenv
printenv ipaddr
setenv ipaddr 192.168.1.100

# Set multiple vars
setenv ipaddr 192.168.1.100
setenv serverip 192.168.1.1
setenv netmask 255.255.255.0

# Lưu vào flash
saveenv
```

#### Memory

```bash
# Đọc memory (display)
md.l 0x80000000 0x10    # 16 words (64 bytes)
md.b 0x80000000 0x100    # 256 bytes

# Ghi memory (write)
mw.l 0x80000000 0x12345678 1
mw.b 0x80000000 0xFF

# Modify memory tương tác
mm.l 0x80000000
# Gõ giá trị mới, nhấn Enter để next, q để thoát
```

#### Storage

```bash
# Thông tin MMC/SD
mmc info
mmc dev 0          # Chọn device 0 (eMMC)
mmc dev 1          # Chọn device 1 (SD card)

# Đọc file từ MMC
mmc read 0x82000000 0x800 0x800   # addr, start block, count

# Ghi file vào MMC
mmc write 0x82000000 0x800 0x800
```

#### Network

```bash
# Ping
ping 192.168.1.1

# DHCP
dhcp

# TFTP download
setenv serverip 192.168.1.1
tftp 0x82000000 uImage       # Download vào memory

# TFTP upload
tftpput 0x82000000 0x10000 test.txt
```

#### Filesystem

```bash
# List FAT filesystem
fatls mmc 0:1

# Load kernel từ FAT
fatload mmc 0:1 0x82000000 boot/uImage

# List ext2/4 filesystem
ext4ls mmc 0:2 /

# Load từ ext4
ext4load mmc 0:2 0x82000000 /boot/zImage
```

#### Boot

```bash
# Boot zImage (ARM)
bootz 0x82000000 - 0x88000000
# syntax: bootz <kernel_addr> <initrd_addr> <dtb_addr>

# Boot Image (ARM64)
booti 0x82000000 0x88000000 0x88000000
# syntax: booti <kernel_addr> <initrd_addr> <dtb_addr>

# Boot theo bootcmd
boot
```

### 4.7 Thiết lập Bootargs (Kernel Command Line)

```bash
# Xem bootargs hiện tại
printenv bootargs

# Set bootargs cho NFS boot
setenv bootargs console=ttyS0,115200 root=/dev/nfs \
nfsroot=192.168.1.1:/nfs/root ip=192.168.1.100:::::eth0:off

# Set bootargs cho SD card boot
setenv bootargs console=ttyS0,115200 root=/dev/mmcblk0p2 \
rootwait rw

# Set bootargs cho eMMC boot
setenv bootargs console=ttyS0,115200 root=/dev/mmcblk1p2 \
rootwait rw

saveenv
```

**Các tham số phổ biến trong bootargs:**

| Tham số | Ví dụ | Ý nghĩa |
|---------|-------|----------|
| `console` | `ttyS0,115200` | Serial console device |
| `root` | `/dev/mmcblk0p2` | Root filesystem device |
| `rootwait` | (no value) | Đợi thiết bị ready |
| `rw` | (no value) | Mount read-write |
| `ro` | (no value) | Mount read-only |
| `init` | `/sbin/init` | Init program |
| `ip` | `192.168.1.100::...` | IP address |

### 4.8 Boot Kernel qua TFTP

**Trên Host:**

```bash
# Copy kernel và DTB vào TFTP directory
sudo cp arch/arm/boot/zImage /srv/tftp/
sudo cp arch/arm/boot/dts/am335x-boneblack.dtb /srv/tftp/

# Đảm bảo quyền
sudo chmod 644 /srv/tftp/*
```

**Trên U-Boot:**

```bash
setenv serverip 192.168.1.1
setenv ipaddr 192.168.1.100
setenv bootdelay 3

# Tải kernel qua TFTP
tftp 0x82000000 zImage

# Tải DTB
tftp 0x88000000 am335x-boneblack.dtb

# Boot
setenv bootargs console=ttyS0,115200 root=/dev/mmcblk0p2 rootwait
bootz 0x82000000 - 0x88000000
```

### 4.9 Tự động hóa với bootcmd

```bash
# Tạo bootcmd cho TFTP boot
setenv bootcmd 'tftp 0x82000000 zImage; tftp 0x88000000 am335x-boneblack.dtb; bootz 0x82000000 - 0x88000000'

# Hoặc boot từ MMC
setenv bootcmd 'mmc dev 0; fatload mmc 0:1 0x82000000 zImage; fatload mmc 0:1 0x88000000 am335x-boneblack.dtb; bootz 0x82000000 - 0x88000000'

saveenv
boot
```

### 4.10 Flash U-Boot vào eMMC/SD

```bash
# Trên host, tạo image
# BeagleBone Black

# Mount SD card (hoặc eMMC qua USB)
sudo dd if=u-boot/MLO of=/dev/sdX count=1 seek=1 bs=128k
sudo dd if=u-boot/u-boot.img of=/dev/sdX count=2 seek=1 bs=384k

# Hoặc format và partition
sudo fdisk /dev/sdX  # Tạo partitions
#bootloader partition: 1MB
#kernel partition: 10MB  
#rootfs partition: còn lại
```

### Bài tập Chương 4

**Bài 4.1:** Build U-Boot cho BeagleBone Black từ source:
```bash
git clone https://gitlab.denx.de/u-boot/u-boot.git
cd u-boot
make am335x_boneblack_defconfig
make -j$(nproc)
ls -la MLO u-boot.img u-boot.dtb
```

**Bài 4.2:** Tạo boot script để boot kernel từ TFTP:
```bash
# Tạo boot script text
cat > boot.scr << 'EOF'
setenv serverip 192.168.1.1
setenv ipaddr 192.168.1.100
setenv bootdelay 3

tftp 0x82000000 zImage
tftp 0x88000000 am335x-boneblack.dtb
setenv bootargs console=ttyS0,115200 root=/dev/mmcblk0p2 rootwait rw
bootz 0x82000000 - 0x88000000
EOF

# Compile thành U-Boot script image
mkimage -A arm -O linux -T script -C none -a 0 -e 0 \
    -n "Boot Script" -d boot.scr boot.scr.uimg

# Copy vào boot partition
cp boot.scr.uimg /boot/
```

---

## Chương 5: Linux Kernel

### Mục tiêu học tập
- Hiểu kiến trúc Linux kernel
- Cấu hình và compile kernel
- Truyền boot parameters
- Sử dụng kernel modules

### 5.1 Vai trò của Linux Kernel

**Kernel là trái tim của hệ điều hành:**

1. **Quản lý tài nguyên phần cứng**
   - CPU: Schedule processes
   - Memory: Allocate/free memory
   - I/O: Device access

2. **Cung cấp abstraction**
   - File systems (VFS)
   - Network sockets
   - Process management

3. **System calls interface**
   - ~400 system calls
   - Giao diện giữa user-space và kernel

### 5.2 Linux Kernel Versioning

```
<major>.<minor>.<patch>
   │      │       │
   │      │       └── Patch level (bug fixes)
   │      └────────── Minor version (new features)
   └───────────────── Major version
```

**Các phiên bản quan trọng:**

| Version | Thời gian | Ghi chú |
|---------|-----------|---------|
| 2.6.x | 2003-2011 | Long era |
| 3.x | 2011-2015 | Renumbering |
| 4.x | 2015-2019 | Stable |
| 5.x | 2019-2026 | Current (LTS: 5.10, 5.15) |
| 6.x | 2026+ | Current |

**LTS (Long Term Support):** 6.6, 6.1, 5.10, 5.15, 4.19, 4.14, 4.9, 4.4

### 5.3 Lấy Kernel Source

```bash
# Clone từ official repository
git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
cd linux

# Hoặc clone mirror
git clone https://github.com/torvalds/linux.git

# Kiểm tra tags
git tag | grep -E "^v[0-9]+\.[0-9]+$" | sort -V | tail -10
git tag | grep "6.6"  # Tìm LTS version
```

### 5.4 Cấu hình Kernel

Kernel có hàng nghìn options. Có 3 cách cấu hình:

#### Cách 1: Sử dụng defconfig có sẵn

```bash
# Xem các defconfig cho ARM
ls arch/arm/configs/
ls arch/arm64/configs/

# Sử dụng
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- \
    multi_v7_defconfig

# Hoặc cho BeagleBone Black
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- \
    bb.org_defconfig
```

#### Cách 2: Dùng menuconfig

```bash
# Cần cài ncurses dev
sudo apt install libncurses-dev

# Mở menu
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- menuconfig
```

**Các mục quan trọng trong menuconfig:**

```
[*] General setup
    → Local version (-append to kernel release)
    → CONFIG_CGROUPS
    → CONFIG_MODULES

[*] Enable loadable module support
    → Module unloading
    → Module versioning

[*] System Type
    → ARM system type
    → (*nần chọn SoC của bạn*)

[*] Kernel Features
    → Memory model (Flat Memory)
    → VM space (tùy RAM board)

[*] Networking support
    → [*] TCP/IP networking
    → [*] IP multicast routing

[*] Device Drivers
    → [*] Generic Driver Options
    → [*] PCI support
    → [*] Network device support
        → [*] Ethernet (10/100/1000)
    → [*] I2C support
    → [*] SPI support
    → [*] GPIO Support
    → [*] USB support
    → [*] MMC/SD/SDIO support
    → [*] Block devices
    → [*] Input device support

[*] File systems
    → [*] Ext4
    → [*] Network File Systems
        → [*] NFS client support
        → [*] CIFS support
```

#### Cách 3: Cập nhật config từ kernel mới

```bash
# Giữ lại config cũ, chỉ thêm options mới
make ARCH=arm oldconfig
```

### 5.5 Compile Kernel

```bash
# Thiết lập environment
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
export PATH="/opt/toolchain/bin:$PATH"

# Compile với nhiều cores
make -j$(nproc)

# Sau khi compile xong, output:
# arch/arm/boot/zImage    → Kernel image cho ARM
# vmlinux                 → ELF image (debugging)
```

**Các output files:**

| File | Mô tả | Vị trí |
|------|-------|--------|
| `zImage` | Compressed ARM kernel | `arch/arm/boot/zImage` |
| `Image` | Raw ARM kernel | `arch/arm/boot/Image` |
| `vmlinux` | ELF (debugging) | Root |
| `*.dtb` | Device tree blobs | `arch/arm/boot/dts/` |

### 5.6 Cài đặt Kernel Modules

```bash
# Cài vào thư mục root filesystem
sudo make ARCH=arm INSTALL_MOD_PATH=/path/to/rootfs \
    modules_install

# Kết quả trong /path/to/rootfs/lib/modules/<version>/
```

### 5.7 Thiết lập Kernel Command Line (bootargs)

**Trong U-Boot:**

```bash
# Ví dụ boot từ SD card
setenv bootargs 'console=ttyS0,115200 root=/dev/mmcblk0p2 rootwait rw'

# Ví dụ boot qua NFS
setenv bootargs 'console=ttyS0,115200 \
root=/dev/nfs \
nfsroot=192.168.1.1:/nfs/root \
ip=192.168.1.100:192.168.1.1:192.168.1.1:255.255.255.0::eth0:off'
```

### 5.8 Kernel Modules

#### Xem modules đã load

```bash
# Trên board
lsmod
cat /proc/modules

# Chi tiết module
modinfo <module_name>
```

#### Load/Unload modules

```bash
# Load module
insmod module_name.ko

# Load với parameters
insmod module_name.ko param1=value1 param2=value2

# Unload module
rmmod module_name

# Load tự động (gọi modprobe)
modprobe module_name
```

#### Tạo module đơn giản (Hello World)

**hello.c:**

```c
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Your Name");
MODULE_DESCRIPTION("Simple Hello World Module");
MODULE_VERSION("1.0");

static int __init hello_init(void) {
    printk(KERN_INFO "Hello, Embedded Linux!\n");
    return 0;
}

static void __exit hello_exit(void) {
    printk(KERN_INFO "Goodbye!\n");
}

module_init(hello_init);
module_exit(hello_exit);
```

**Makefile:**

```makefile
obj-m += hello.o

KDIR ?= /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

all:
    $(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
    $(MAKE) -C $(KDIR) M=$(PWD) clean
```

**Cross-compile module:**

```makefile
obj-m += hello.o

ARCH ?= arm
CROSS_COMPILE ?= arm-linux-gnueabihf-
KDIR ?= /path/to/linux

all:
    $(MAKE) -C $(KDIR) ARCH=$(ARCH) \
        CROSS_COMPILE=$(CROSS_COMPILE) M=$(PWD) modules

clean:
    $(MAKE) -C $(KDIR) ARCH=$(ARCH) \
        CROSS_COMPILE=$(CROSS_COMPILE) M=$(PWD) clean
```

**Build và test:**

```bash
# Trên host
make

# Copy sang board
scp hello.ko root@192.168.1.100:/tmp/

# Trên board
insmod /tmp/hello.ko
dmesg | tail
rmmod hello
```

### 5.9 Kernel Logging

```bash
# Xem kernel log
dmesg

# Real-time
dmesg -w

# Filter by level
dmesg -l info,warning,err

# Xem /dev/kmsg (continuous)
cat /dev/kmsg
```

### Bài tập Chương 5

**Bài 5.1:** Build Linux kernel cho BeagleBone Black:

```bash
# Clone kernel
git clone https://github.com/beagleboard/linux.git
cd linux

# Checkout compatible version
git checkout 5.10.168-ti-arm64-r99

# Cấu hình
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- \
    bb.org_defconfig

# Build
make -j$(nproc) ARCH=arm \
    CROSS_COMPILE=arm-linux-gnueabihf- zImage dtbs

# Output:
# arch/arm/boot/zImage
# arch/arm/boot/dts/am335x-boneblack.dtb
```

**Bài 5.2:** Viết một kernel module đơn giản theo dõi GPIO button press.

---

## Chương 6: Root Filesystem

### Mục tiêu học tập
- Hiểu cấu trúc Filesystem Hierarchy Standard (FHS)
- Tạo root filesystem tối giản
- Sử dụng initramfs
- Mount filesystem qua NFS

### 6.1 Filesystem Hierarchy Standard (FHS)

**FHS** định nghĩa cấu trúc thư mục chuẩn:

```
/                           Root - điểm bắt đầu
├── bin/                    User binaries (essential)
├── boot/                  Boot files (kernel, bootloader)
├── dev/                   Device files
├── etc/                   Configuration files
│   ├── init.d/            Init scripts
│   ├── systemd/           systemd units
│   └── network/           Network config
├── home/                  User home directories
├── lib/                   Shared libraries
├── media/                 Removable media mounts
├── mnt/                   Temporary mounts
├── opt/                   Optional software
├── proc/                  Process info (pseudo-fs)
├── root/                  Root user home
├── run/                   Runtime data
├── sbin/                  System binaries
├── sys/                   System info (pseudo-fs)
├── tmp/                   Temporary files
├── usr/                   User programs
│   ├── bin/
│   ├── lib/
│   └── share/
└── var/                   Variable data (logs, cache)
```

### 6.2 Tạo Root Filesystem cơ bản

#### Bước 1: Tạo thư mục cấu trúc

```bash
# Tạo thư mục rootfs
mkdir -p ~/rootfs/{bin,sbin,etc,proc,sys,dev,lib,usr/{bin,lib},var/{log,run,tmp}}
mkdir -p ~/rootfs/boot
mkdir -p ~/rootfs/root

# Phân quyền
sudo chmod 1777 ~/rootfs/var/tmp
```

#### Bước 2: Copy BusyBox binaries

```bash
# Copy busybox (sẽ học ở chương 7)
cp -a _install/* ~/rootfs/

# Kiểm tra
ls ~/rootfs/bin/
ls ~/rootfs/sbin/
```

#### Bước 3: Tạo device nodes

```bash
# Tạo console và null devices (cần sudo)
sudo mknod ~/rootfs/dev/console c 5 1
sudo mknod ~/rootfs/dev/null c 1 3
sudo chmod 666 ~/rootfs/dev/null
```

#### Bước 4: Tạo init script

```bash
cat > ~/rootfs/init << 'EOF'
#!/bin/sh

# Mount pseudo-filesystems
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev

# Set PATH
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

# Welcome message
echo "====================================="
echo "  Embedded Linux Root Filesystem"
echo "====================================="

# Start shell
exec /bin/sh
EOF

chmod +x ~/rootfs/init
```

#### Bước 5: Tạo filesystem image

```bash
# Tạo ext4 image 256MB
dd if=/dev/zero of=rootfs.ext4 bs=1M count=256
mkfs.ext4 -F rootfs.ext4

# Mount và copy files
mkdir -p /mnt/tmp
sudo mount -o loop rootfs.ext4 /mnt/tmp
sudo cp -a ~/rootfs/* /mnt/tmp/
sudo umount /mnt/tmp
```

### 6.3 initramfs

**initramfs** là CPIO archive được unpack vào RAM trước khi mount root filesystem thực.

**Khi nào cần initramfs:**
- Root filesystem nằm trong encrypted container
- Cần load kernel modules trước khi mount root
- Booting từ network (PXE)
- Root filesystem trong RAID/LVM

#### Tạo initramfs đơn giản

```bash
mkdir -p initramfs/{bin,sbin,etc,proc,sys,lib,dev}
cd initramfs

# Copy busybox
cp -a /path/to/busybox/_install/bin/busybox bin/
for app in sh cat echo ls mount umount; do
    ln -sf busybox bin/$app
done

# Tạo init script
cat > init << 'EOF'
#!/bin/sh
echo "=== initramfs started ==="

# Mount
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev

echo "=== switching to real root ==="

# Mount real root
mount -o ro /dev/mmcblk0p2 /mnt

# Switch root
exec switch_root /mnt /sbin/init
EOF
chmod +x init

# Tạo CPIO archive
find . -cpio -o -H newc | gzip > ../initramfs.cpio.gz

cd ..
ls -lh initramfs.cpio.gz
```

#### Sử dụng initramfs trong U-Boot

```bash
# Tải kernel, initramfs, và DTB
tftp 0x82000000 zImage
tftp 0x83000000 initramfs.cpio.gz
tftp 0x88000000 board.dtb

# Boot với initramfs
setenv bootargs console=ttyS0,115200
bootz 0x82000000 0x83000000 0x88000000
```

### 6.4 NFS Boot

Cho phép boot root filesystem từ host qua mạng.

#### Cấu hình Host (NFS Server)

```bash
# Cài đặt
sudo apt install nfs-kernel-server

# Thêm vào /etc/exports
echo '/nfs/root  *(rw,sync,no_subtree_check,no_root_squash,no_all_squash)' \
    | sudo tee -a /etc/exports

# Export
sudo exportfs -ra

# Kiểm tra
sudo exportfs -v
```

#### Cấu hình Kernel cho NFS

Trong kernel config:
```
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_ROOT_NFS=y
CONFIG_IP_PNP=y
CONFIG_NETWORK_FILESYSTEMS=y
```

#### Boot từ U-Boot

```bash
# Set bootargs cho NFS
setenv bootargs console=ttyS0,115200 \
    root=/dev/nfs \
    nfsroot=192.168.1.1:/nfs/root \
    ip=192.168.1.100:192.168.1.1:192.168.1.1:255.255.255.0::eth0:off

boot
```

### 6.5 Tự động mount với systemd

```ini
# /etc/systemd/system/boot.mount
[Unit]
Description=Boot Partition
After=local-fs.target

[Mount]
What=/dev/mmcblk0p1
Where=/boot
Type=vfat
Options=defaults

[Install]
WantedBy=local-fs.target
```

```bash
systemctl enable boot.mount
```

### Bài tập Chương 6

**Bài 6.1:** Tạo một root filesystem tối giản và boot thử qua NFS:
1. Tạo thư mục `/nfs/root`
2. Copy BusyBox vào đó
3. Tạo init script
4. Cấu hình NFS exports
5. Boot từ board

**Bài 6.2:** Tạo initramfs để load ext4 module trước khi mount root.

---

## Chương 7: BusyBox - Tạo hệ thống tối giản

### Mục tiêu học tập
- Hiểu vai trò của BusyBox
- Build BusyBox với cấu hình tùy chỉnh
- Tạo hệ thống init đơn giản

### 7.1 Giới thiệu BusyBox

**BusyBox** là một executable duy nhất cung cấp hầu hết các lệnh UNIX cơ bản.

**Ưu điểm:**
- Kích thước nhỏ (<1 MB)
- Tất cả trong một file
- Dễ cấu hình
- Phổ biến trong embedded

**Lịch sử:**
- 1995: Tạo bởi Bruce Perens cho Debian rescue disk
- License: GPLv2

### 7.2 Lấy và cấu hình BusyBox

```bash
# Clone repository
git clone https://git.busybox.net/busybox
cd busybox

# Checkout stable version
git checkout 1.36.1

# Cấu hình
make defconfig          # Default (hầu hết features)
# hoặc
make allnoconfig        # Minimal
# hoặc
make menuconfig         # Interactive
```

**Trong menuconfig, các mục quan trọng:**

```
Busybox Settings
├── Build Options
│   ├── [*] Build BusyBox as a static binary (no shared libs)
│   └── [*] Force NOMineglected for uClibc
├── Installation Options
│   └── BusyBox installation prefix: /path/to/rootfs
├── Coreutils
│   └── [*] cat, cp, ls, mkdir, rm, etc.
├── Shells
│   └── [*] ash (smallest shell)
├── Networking Utilities
│   └── [*] ping, ifconfig, wget, etc.
├── Process Utilities
│   └── [*] ps, top, kill
└── System Utilities
    └── [*] dmesg, lsmod, insmod, mdev
```

### 7.3 Build BusyBox

```bash
# Build cho x86 (host)
make -j$(nproc)

# Cross-compile cho ARM
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
make -j$(nproc)

# Install vào rootfs
make CONFIG_PREFIX=/path/to/rootfs install
```

### 7.4 Cấu trúc sau khi install

```
/path/to/rootfs/
├── bin/
│   ├── busybox → busybox
│   ├── cat, cp, ls, mkdir... (symlinks to busybox)
├── sbin/
│   ├── busybox → ../bin/busybox
│   ├── init, mdev, ifconfig... (symlinks)
└── usr/
    └── bin/
        └── busybox → ../../bin/busybox
```

### 7.5 Sử dụng BusyBox

```bash
# Cách 1: Gọi trực tiếp
busybox ls -la /

# Cách 2: Qua symlinks (đã có sẵn khi install)
ls -la /

# Xem tất cả applets có sẵn
busybox --list
```

### 7.6 Tạo Init System với BusyBox

#### init từ scratch

```bash
# /path/to/rootfs/init (executable)
#!/bin/sh

# Mount pseudo-filesystems
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs devtmpfs /dev

# Set PATH
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

# Khởi tạo mdev (device manager)
echo "/sbin/mdev" > /proc/sys/kernel/hotplug
mdev -s

# Welcome message
echo ""
echo "====================================="
echo "  Embedded Linux - BusyBox System"
echo "====================================="
echo ""

# Mount filesystems
mount -a

# Start networking (nếu có)
ifconfig lo 127.0.0.1 up

# Đợi shell
exec /bin/sh -l
```

#### BusyBox init (rcS style)

```bash
# /path/to/rootfs/etc/inittab
::sysinit:/etc/init.d/rcS
::restart:/sbin/init
::ctrlaltdel:/sbin/reboot
::shutdown:/etc/init.d/rcK

# /path/to/rootfs/etc/init.d/rcS
#!/bin/sh
echo "Running rcS..."

# Mount filesystems
mount -a

# Populate /dev with mdev
echo /sbin/mdev > /proc/sys/kernel/hotplug
mdev -s

# Setup network
ifconfig eth0 192.168.1.100 up

# Start services
/etc/init.d/networking start
/etc/init.d/sshd start
```

```bash
# Phân quyền
chmod +x /path/to/rootfs/etc/init.d/rcS
```

### 7.7 Minimal /etc cho hệ thống hoạt động

```bash
cd /path/to/rootfs

# /etc/passwd
cat > etc/passwd << 'EOF'
root:x:0:0:root:/root:/bin/sh
daemon:x:1:1:daemon:/usr/sbin:/bin/false
nobody:x:65534:65534:nobody:/var:/bin/false
EOF

# /etc/group
cat > etc/group << 'EOF'
root:x:0:
daemon:x:1:
tty:x:5:
EOF

# /etc/shadow (optional)
cat > etc/shadow << 'EOF'
root:*:0:0:99999:7:::
EOF
chmod 600 etc/shadow

# /etc/fstab
cat > etc/fstab << 'EOF'
proc  /proc  proc  defaults  0  0
tmpfs /tmp   tmpfs defaults  0  0
tmpfs /run   tmpfs defaults  0  0
sysfs /sys   sysfs defaults  0  0
devpts /dev/pts devpts defaults  0  0
EOF

# /etc/profile
cat > etc/profile << 'EOF'
export PATH=/bin:/sbin:/usr/bin:/usr/sbin
export PS1='\u@\h:\w\$ '
alias ll='ls -la'
EOF

# /etc/mdev.conf (để mdev tự động tạo device nodes)
# Syntax: regex user:group mode [action]
null    0:0 0666
zero    0:0 0666
console 0:0 0600
tty     0:0 0666
tty0    0:0 0660
fb/*    0:0 0660
mmcblk[0-9]*p[0-9]*  0:0 0660 =block
sd[a-z][0-9]*        0:0 0660 =block
```

### 7.8 Một số lệnh hữu ích với BusyBox

```bash
# Shell
ash                    # Ash shell (nhẹ nhất)
sh                     # symlink to ash

# File operations
ls, cd, pwd, cp, mv, rm, mkdir, rmdir
cat, head, tail, more, less
dd, sync

# Text processing
grep, sed, awk, find, xargs

# Networking
ifconfig, route, ping, wget
telnet, ftpget, ftpd

# System
ps, top, kill, free, df, du
insmod, lsmod, rmmod, mdev

# Archives
tar, gzip, bzip2, unzip, cpio

# Misc
date, uptime, hostname, dmesg
```

### Bài tập Chương 7

**Bài 7.1:** Build BusyBox và tạo root filesystem hoàn chỉnh:

```bash
# 1. Clone và build BusyBox
git clone https://git.busybox.net/busybox
cd busybox
make defconfig
make -j$(nproc)

# 2. Install
make CONFIG_PREFIX=~/rootfs install

# 3. Tạo cấu trúc thêm
cd ~/rootfs
mkdir -p etc/init.d dev proc sys lib

# 4. Tạo init script (xem 7.6)

# 5. Tạo /etc files (xem 7.7)

# 6. Test với chroot
sudo chroot ~/rootfs /bin/sh
```

**Bài 7.2:** Thêm init script để:
- Auto-start SSH server (dropbear)
- Tự động mount USB khi cắm

---

## Chương 8: Device Tree

### Mục tiêu học tập
- Hiểu Device Tree là gì và tại sao cần nó
- Đọc và viết Device Tree Source
- Compile và sử dụng Device Tree

### 8.1 Tại sao cần Device Tree?

Trên PC, hardware được **detect tự động** (Plug-and-Play). Nhưng trên embedded SoC, nhiều thiết bị **không detect được** tự động (GPIO, I2C, SPI...).

**Device Tree** là cách mô tả hardware bằng text, kernel đọc và load driver tương ứng.

```
┌─────────────────────────────────────┐
│         Device Tree (.dts)          │
│                                     │
│  cpu { }                           │
│  serial@40000000 { }               │
│  i2c@40013000 {                    │
│      sensor@50 { }                 │
│  }                                 │
└─────────────────────────────────────┘
            │
            │ dtc (compile)
            ▼
┌─────────────────────────────────────┐
│       Device Tree Blob (.dtb)       │
└─────────────────────────────────────┘
            │
            │ kernel đọc lúc boot
            ▼
┌─────────────────────────────────────┐
│         Kernel hỗ trợ driver       │
│                                     │
│  compatible="st,stm32-usart"  ──▶ serial driver
│  compatible="microchip,24c256" ──▶ I2C EEPROM driver
└─────────────────────────────────────┘
```

### 8.2 Device Tree Basics

#### File formats

| Format | Extension | Mô tả |
|--------|----------|-------|
| **DTS** (Source) | `.dts` | Text format |
| **DTSI** (Include) | `.dtsi` | Common definitions (include) |
| **DTB** (Blob) | `.dtb` | Binary format (kernel đọc) |

#### Cấu trúc cơ bản

```dts
/dts-v1/;                    // Version 1

/ {
    compatible = "myvendor,myboard";   // Match với driver
    #address-cells = <1>;              // Số cells cho address
    #size-cells = <1>;                 // Số cells cho size

    cpus {
        #address-cells = <1>;
        #size-cells = <0>;            // Size không cần

        cpu@0 {
            device_type = "cpu";
            compatible = "arm,cortex-a7";
            reg = <0>;                 // CPU number
        };
        cpu@1 {
            device_type = "cpu";
            compatible = "arm,cortex-a7";
            reg = <1>;
        };
    };

    soc {
        #address-cells = <1>;
        #size-cells = <1>;
        compatible = "simple-bus";

        /* Serial UART */
        serial@40000000 {
            compatible = "st,stm32-usart";
            reg = <0x40000000 0x200>;  // address, size
            interrupts = <37>;         // IRQ number
            status = "okay";
        };

        /* I2C bus */
        i2c@40013000 {
            compatible = "st,stm32f7-i2c";
            reg = <0x40013000 0x400>;
            #address-cells = <1>;
            #size-cells = <0>;

            /* EEPROM trên I2C bus */
            eeprom@50 {
                compatible = "microchip,24c256";
                reg = <0x50>;         // I2C address
            };
        };

        /* GPIO */
        gpioa: gpio@48000000 {
            compatible = "st,stm32-gpio";
            reg = <0x48000000 0x400>;
            gpio-controller;
            #gpio-cells = <2>;
        };

        /* LED connected to GPIO */
        led {
            compatible = "gpio-leds";
            gpios = <&gpioa 3 GPIO_ACTIVE_HIGH>;
            linux,default-trigger = "heartbeat";
        };
    };
};
```

### 8.3 Device Tree Compiler (dtc)

```bash
# Cài đặt
sudo apt install device-tree-compiler

# Compile DTS -> DTB
dtc -I dts -O dtb -o output.dtb input.dts

# Decompile DTB -> DTS
dtc -I dtb -O dts -o output.dts input.dtb

# Với include path
dtc -I dts -O dtb -o output.dtb \
    -@ \                    # Enable overlays
    -b 0 \                  # Boot CPU
    -R 4 \                  # Reserved memory regions
    -p 256 \                # Padding
    -i /path/to/includes/ \
    -o output.dtb input.dts
```

### 8.4 Important Properties

#### compatible

```dts
compatible = "vendor,chip-name", "simple-bus";
```
Kernel tìm driver có cùng `compatible` string.

#### reg

```dts
reg = <address size>;           // 1 cell address, 1 cell size
reg = <addr1 size1 addr2 size2>; // Multiple ranges
reg = <0x40000000 0x200>;        // 512 bytes từ 0x40000000
```

#### interrupts

```dts
interrupts = <IRQ_NUM IRQ_TYPE>;  // ARM: PPI (16-31), SPI (32+)
interrupts = <37 IRQ_TYPE>;

#interrupt-cells = <2>;           // Số cells cho mỗi interrupt
// IRQ_TYPE: 1=IRQ_TYPE_EDGE_RISING
//           2=IRQ_TYPE_EDGE_FALLING
//           4=IRQ_TYPE_EDGE_HIGH
//           8=IRQ_TYPE_EDGE_LOW
```

#### status

```dts
status = "okay";      // Enabled
status = "disabled";  // Disabled
status = "reserved";  // Reserved, don't use
```

### 8.5 Device Tree Overlays (DTO)

Cho phép modify device tree lúc runtime (để enable/disable hardware).

```dts
/dts-v1/;
/plugin/;

&i2c1 {
    status = "okay";

    /* Add new device vào i2c1 */
    sensor@68 {
        compatible = "invensense,mpu6050";
        reg = <0x68>;
        interrupts = <78 IRQ_TYPE_EDGE_RISING>;
    };
};

&gpioa {
    /* Modify existing GPIO */
};
```

### 8.6 Ví dụ thực tế: BeagleBone Black

**File: am335x-boneblack.dts**

```dts
/dts-v1/;

#include "am33xx.dtsi"

/ {
    model = "TI AM335x BeagleBone Black";
    compatible = "ti,am335x-boneblack", "ti,am335x-bone", "ti,am33xx";

    leds {
        compatible = "gpio-leds";
        pinctrl-names = "default";

        led@0 {
            label = "beaglebone:green:usr0";
            gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
            default-state = "off";
        };
        led@1 {
            label = "beaglebone:green:usr1";
            gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
            default-state = "off";
        };
    };

    /* HDMI framebuffer */
    codec {
        compatible = "ti,tilcdc,slave";
    };
};

&mmc1 {
    status = "okay";
    cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
    wp-gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
};

&mmc2 {
    status = "okay";
    bus-width = <4>;
    cap-sd-highspeed;
    cd-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
};

&usb0 {
    status = "okay";
    dr_mode = "host";
};

&usb1 {
    status = "okay";
    dr_mode = "host";
};
```

### 8.7 Debug Device Tree

```bash
# Trên board, xem device tree
cat /proc/device-tree/

# Hoặc dùng fdtdump
fdtget -p /boot/dtbs/*.dtb /

# Xem compatible string
cat /proc/device-tree/compatible

# Xem CPU info
cat /proc/device-tree/cpus/*/reg
```

### Bài tập Chương 8

**Bài 8.1:** Tạo device tree overlay để enable thêm I2C device trên BeagleBone:
1. Tìm I2C bus 2 (P9.19, P9.20)
2. Tạo overlay enable I2C-2
3. Add một sensor (giả sử TMP102, address 0x48)
4. Compile và apply

```dts
/dts-v1/;
/plugin/;

/ {
    compatible = "ti,am335x";
};

&i2c2 {
    status = "okay";

    tmp102@48 {
        compatible = "ti,tmp102";
        reg = <0x48>;
    };
};
```

**Bài 8.2:** Tạo device tree để configure PWM cho điều khiển LED dimming.

---

## Chương 9: Filesystem

### Mục tiêu học tập
- Phân biệt các loại filesystem
- Chọn filesystem phù hợp cho từng use case
- Tạo và mount filesystem

### 9.1 Phân loại Filesystem

```
┌─────────────────────────────────────────────────────┐
│                    FILESYSTEMS                       │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ┌─────────────────┐  ┌─────────────────────────┐   │
│  │ Block Filesystem │  │  Flash Filesystem       │   │
│  │ (Random access)  │  │  (Erase-before-write)   │   │
│  ├─────────────────┤  ├─────────────────────────┤   │
│  │ ext4            │  │ MTD-specific:            │   │
│  │ Btrfs           │  │   JFFS2                  │   │
│  │ XFS             │  │   UBI/UBIFS              │   │
│  │ F2FS            │  │   YAFFS2                 │   │
│  │ SquashFS (ro)   │  │                          │   │
│  │ EROFS (ro)      │  │ Block-emulated:          │   │
│  │                 │  │   mtdblock               │   │
│  │                 │  │   ubiblock               │   │
│  └─────────────────┘  └─────────────────────────┘   │
│                                                     │
│  ┌─────────────────────────────────────────────┐     │
│  │ Pseudo Filesystem (in-memory)               │     │
│  │   proc, sysfs, devtmpfs, tmpfs, debugfs     │     │
│  └─────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────┘
```

### 9.2 Block Filesystems

#### ext4 (Extended Filesystem 4)

**Đặc điểm:**
- Default cho hầu hết Linux systems
- Journaling (không cần fsck sau crash)
- Backward compatible với ext2/3

**Tạo:**
```bash
mkfs.ext4 -L rootfs /dev/mmcblk0p2
mkfs.ext4 -E root_owner=0:0 /dev/mmcblk0p2
```

**Mount:**
```bash
mount -t ext4 /dev/mmcblk0p2 /mnt
```

#### Btrfs (B-Tree Filesystem)

**Đặc điểm:**
- Copy-on-write (COW)
- Snapshots
- Transparent compression (zstd, zlib, lzo)
- Subvolumes
- RAID tích hợp

**Tạo:**
```bash
mkfs.btrfs -L myroot /dev/mmcblk0p2
```

**Tính năng nâng cao:**
```bash
# Tạo subvolume
btrfs subvolume create /mnt/data

# Tạo snapshot
btrfs subvolume snapshot /mnt /mnt/snapshot

# Compression
mount -t btrfs -o compress=zstd /dev/mmcblk0p2 /mnt
```

#### F2FS (Flash-Friendly File System)

**Đặc điểm:**
- Được thiết kế cho flash storage (SSD, eMMC, SD)
- Log-structured filesystem
- Tốt cho embedded

**Tạo:**
```bash
mkfs.f2fs -l rootfs /dev/mmcblk0p2
```

**Mount:**
```bash
mount -t f2fs /dev/mmcblk0p2 /mnt
```

#### SquashFS (Compressed Read-Only)

**Đặc điểm:**
- **Read-only**, highly compressed
- Tốt cho kernel, root filesystem read-only
- Compression: xz, gzip, lz4, zstd
- **Best compression ratio**

**Tạo:**
```bash
# Từ thư mục
mksquashfs source_dir rootfs.squashfs -comp xz

# Với options
mksquashfs source_dir rootfs.squashfs \
    -comp zstd \
    -b 131072 \
    -no-xattrs \
    -all-root
```

**Mount:**
```bash
mount -t squashfs rootfs.squashfs /mnt -o loop
```

#### EROFS (Enhanced Read-Only FS)

**Đặc điểm:**
- Read-only
- **Faster read** so với SquashFS
- Dùng trong Android phones
- Fixed-block output

**Tạo:**
```bash
mkfs.erofs -L rootfs rootfs.erofs source_dir/
```

### 9.3 So sánh Filesystems

| FS | Type | Compression | Journal | Notes |
|----|------|-------------|---------|-------|
| **ext4** | rw | No | Yes | Default choice |
| **Btrfs** | rw | Yes | No (COW) | Advanced features |
| **F2FS** | rw | Optional | No | Flash-optimized |
| **SquashFS** | ro | Yes | No | Kernel, read-only parts |
| **EROFS** | ro | Yes | No | Fast, Android phones |
| **XFS** | rw | No | Yes | High-performance |

### 9.4 Flash Filesystems (MTD)

#### JFFS2

```bash
# Tạo image
mkfs.jffs2 -d /path/to/rootfs \
    -o rootfs.jffs2 \
    -e 0x20000 \       # Erase block size
    --pad=0x800000     # Pad to size

# Mount trên host (cần mtd-utils)
sudo modprobe mtdram total_size=131072
sudo modprobe mtdblock
dd if=rootfs.jffs2 of=/dev/mtdblock0
mount -t jffs2 /dev/mtdblock0 /mnt
```

#### UBI/UBIFS

**UBI layer:**
```bash
# Tạo UBI image
mkfs.ubifs -d /path/to/rootfs \
    -o rootfs.ubifs \
    -e 0x1F800 \       # Logical erase block
    -c 4095 \         # Max logical erase blocks
    -m 0x800          # Minimum I/O unit

# Tạo UBI volume
cat > ubinize.cfg << 'EOF'
[ubifs]
mode=ubi
image=rootfs.ubifs
vol_id=0
vol_size=200MiB
vol_type=dynamic
vol_name=rootfs
vol_flags=autoresize
EOF

ubinize -o ubi.img -O 2048 ubinize.cfg
```

**Mount UBI:**
```bash
# Attach NAND to UBI
ubiattach /dev/ubi_ctrl -m 2

# Mount volume
mount -t ubifs ubi0:rootfs /mnt
```

### 9.5 tmpfs (RAM-based filesystem)

**Đặc điểm:**
- Lưu trong RAM
- Tự động resize
- Dùng cho /tmp, /run, caches

```bash
# Mount tmpfs
mount -t tmpfs -o size=50% tmpfs /tmp

# Trong fstab
tmpfs /tmp tmpfs defaults,size=100M 0 0
tmpfs /var/log tmpfs defaults,size=10M 0 0
tmpfs /var/run tmpfs defaults,size=5M 0 0
```

### 9.6 Overlay Filesystem

Cho phép overlay một filesystem read-only với một writable layer.

```
┌──────────────────────────────────────┐
│            /merged                   │  (upper, writable)
├──────────────────────────────────────┤
│            /upper (tmpfs)            │  (changes)
├──────────────────────────────────────┤
│            /lower (squashfs)         │  (base, read-only)
└──────────────────────────────────────┘
```

```bash
# Mount overlay
mount -t overlay overlay \
    -o lowerdir=/lower,upperdir=/upper,workdir=/work \
    /merged

# Hoặc với tmpfs làm upper
mount -t overlay overlay \
    -o lowerdir=/squashfs,upperdir=/tmp/upper,workdir=/tmp/work \
    /overlay
```

### Bài tập Chương 9

**Bài 9.1:** Tạo root filesystem với nhiều filesystem layers:
- SquashFS cho `/usr` (read-only)
- ext4 cho `/var` (persistent)
- tmpfs cho `/tmp`, `/run` (RAM)

**Bài 9.2:** Benchmark các filesystem để so sánh performance:
```bash
# Tạo test filesystems
dd if=/dev/zero of=test.ext4 bs=1M count=256
dd if=/dev/zero of=test.btrfs bs=1M count=256
dd if=/dev/zero of=test.f2fs bs=1M count=256

# Format
mkfs.ext4 -F test.ext4
mkfs.btrfs -F test.btrfs
mkfs.f2fs -f test.f2fs

# Benchmark với iozone hoặc fio
fio --name=seq_write --filename=test.fs --size=100M --rw=write --bs=1M
fio --name=seq_read --filename=test.fs --size=100M --rw=read --bs=1M
```

---

## Chương 10: Embedded Build Systems

### Mục tiêu học tập
- Hiểu ưu nhược điểm của Buildroot và Yocto
- Build root filesystem với Buildroot
- Tạo image với Yocto

### 10.1 Ba cách tiếp cận để tạo Embedded Linux

| Cách | Độ phức tạp | Thời gian | Package Manager |
|------|-------------|-----------|-----------------|
| **Manual** | Thấp | Rất lâu | Không |
| **Buildroot** | Trung bình | Nhanh | Không |
| **Yocto** | Cao | Chậm (có cache) | Có |

### 10.2 Buildroot

#### Giới thiệu

- Build system dựa trên Makefiles
- ~2800 packages có sẵn
- Hỗ trợ uClibc, glibc, musl
- Không có package manager ( monolithic image)

#### Cài đặt và sử dụng

```bash
# Clone repository
git clone https://github.com/buildroot/buildroot.git
cd buildroot

# Checkout stable version
git checkout 2024.02.1

# Mở menuconfig
make menuconfig

# Build (mất 15-60 phút lần đầu)
make -j$(nproc)
```

#### Cấu hình quan trọng trong menuconfig

```
Target options
├── Target architecture: ARM (little endian)
├── Target architecture variant: cortex-A7
├── Target ABI: EABIhf
└── Emit ARM PLT entries: Yes

Build options
├── Enable compiler cache (ccache): Yes
├── strip target binaries: Yes
└── compilers to use: GCC 13.x

Toolchain
├── C library: glibc
├── Enable C++ support: Yes
├── Enable IPv6 support: Yes
└── Enable RPC support: Yes

System configuration
├── System hostname: mydevice
├── Root filesystem overlay: /path/to/overlay/
├── Init system: BusyBox
└── /dev management: eudev

Kernel
├── Linux Kernel: Yes
├── Kernel configuration: using custom defconfig
└── Kernel binary format: zImage

Target packages
├── Audio and video applications
│   ├── alsa-utils
│   └── espeak
├── Debugging, profiling and benchmark
│   ├── gdb
│   ├── strace
│   └── lmbench
├── Libraries
│   ├── Audio/Sound
│   │   └── alsa-lib
│   ├── Networking
│   │   └── libmnl
│   └── JSON
│       └── cjson
└── Shell and utilities
    └── bash

Filesystem images
├── cpio the root filesystem: yes
├── ext2/3/4 root filesystem: yes
│   ├── ext4 variant: yes
│   └── filesystem size: 256M
└── tar the root filesystem: yes
```

#### Thêm package tùy chỉnh

**Bước 1:** Tạo Makefile (.mk)

```makefile
# package/myapp/myapp.mk
MYAPP_VERSION = 1.0.0
MYAPP_SITE = /path/to/source
MYAPP_SITE_METHOD = local
MYAPP_LICENSE = MIT
MYAPP_INSTALL_TARGET = YES

define MYAPP_BUILD_CMDS
    $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(MYAPP_SITE)
endef

define MYAPP_INSTALL_TARGET_CMDS
    $(MAKE) -C $(MYAPP_SITE) install \
        DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
```

**Bước 2:** Thêm Config.in

```bash
# Thêm vào package/Config.in
source "package/myapp/Config.in"
```

**Bước 3:** Enable trong menuconfig

```
Target packages
└── My Application: Yes
```

#### Kết quả sau build

```
output/
├── images/
│   ├── sdcard.img        # Complete image
│   ├── rootfs.ext4       # Root filesystem
│   ├── zImage            # Kernel
│   └── *.dtb             # Device tree
├── build/
│   └── myapp-1.0.0/     # Build directory
├── host/
│   └── bin/             # Host tools (cross-compilers)
└── staging/            # Sysroot
```

### 10.3 Yocto Project / OpenEmbedded

#### Giới thiệu

- Layer-based architecture
- Phức tạp nhưng rất mạnh mẽ
- Hỗ trợ package management (.deb, .rpm, .ipk)
- Caching tốt, build nhanh lần sau

#### Layers

| Layer | Mô tả |
|-------|-------|
| `poky` | Reference distribution |
| `openembedded-core` | Base metadata |
| `meta-openembedded` | Extra packages (network, audio, etc.) |
| `meta-qt5` / `meta-qt6` | Qt framework |
| `meta-raspberrypi` | Raspberry Pi support |
| `meta-freescale` | NXP/Freescale boards |

#### Setup

```bash
# Clone Poky (Yocto build system)
git clone -b kirkstone https://git.yoctoproject.org/git/poky
cd poky

# Setup build environment
source oe-init-build-env

# Tạo build directory và cd vào
# (oe-init-build-env đã làm điều này)
```

#### Cấu hình (conf/local.conf)

```bash
# Thêm vào local.conf
MACHINE ??= "beaglebone"

# Package format
PACKAGE_CLASSES ?= "package_ipk"

# Parallel build
BB_NUMBER_THREADS ?= "8"
PARALLEL_MAKE ?= "-j 8"

# Image size
IMAGE_ROOTFS_SIZE = "512000"

# Extra packages
IMAGE_INSTALL_append = " \
    openssh \
    python3 \
    git \
    curl \
"
```

#### Cấu hình máy (conf/bblayers.conf)

```bash
# Thêm layers
bitbake-layers add-layer ../meta-openembedded
bitbake-layers add-layer ../meta-qt5
```

#### Build

```bash
# Build core image
bitbake core-image-minimal

# Build với SDK
bitbake core-image-minimal -c populate_sdk

# Build specific package
bitbake myapp
```

#### Viết Recipe đơn giản

```bash
# Tạo layer
bitbake-layers create-layer meta-myapp
bitbake-layers add-layer meta-myapp

# Tạo recipe
mkdir -p meta-myapp/recipes-myapp/myapp
```

```bash
# meta-myapp/recipes-myapp/myapp/myapp_1.0.bb
DESCRIPTION = "My first Yocto application"
HOMEPAGE = "https://example.com"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=..."

SRC_URI = "git://github.com/myuser/myapp.git;branch=main;protocol=https"
SRCREV = "${AUTOREV}"

inherit cmake

EXTRA_OECONF = ""

BBCLASSEXTEND = "native nativesdk"
```

### 10.4 So sánh Buildroot vs Yocto

| Tiêu chí | Buildroot | Yocto/OpenEmbedded |
|----------|-----------|-------------------|
| **Độ phức tạp** | Thấp | Cao |
| **Learning curve** | Dễ hơn | Khó hơn |
| **Thời gian build lần đầu** | 15-60 phút | 1-4 giờ |
| **Build lần sau** | Chậm (no cache) | Nhanh (sstate cache) |
| **Package manager** | Không | Có (.deb, .rpm, .ipk) |
| **Customization** | Limited options | Rất linh hoạt |
| **Layer system** | Không | Có |
| **Best for** | Simple devices | Complex products |

### 10.5 Khi nào dùng gì?

```
┌─────────────────────────────────────────────────────────────┐
│                    DECISION GUIDE                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  RAM < 256 MB?                                              │
│     ├── Yes ──▶ Buildroot (uClibc)                          │
│     │                                                        │
│     └── No ──▶ Thiết bị phức tạp?                          │
│               ├── Cần nhiều packages?                      │
│               │    ├── Yocto                               │
│               │    └── Không ──▶ Buildroot (glibc)        │
│               │                                             │
│               └── Production với package management?        │
│                   └── Yocto                                 │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Bài tập Chương 10

**Bài 10.1:** Build root filesystem với Buildroot cho Raspberry Pi 4:
```bash
git clone https://github.com/buildroot/buildroot.git
cd buildroot

# Cấu hình
make raspberrypi4_64_defconfig
make menuconfig

# Build (chạy overnight nếu cần)
make -j$(nproc)

# Kết quả trong output/images/
ls -la output/images/
```

**Bài 10.2:** Tạo một Yocto layer đơn giản với application của bạn.

---

## Chương 11: Phát triển Ứng dụng

### Mục tiêu học tập
- Thiết lập môi trường phát triển cross-compile
- Sử dụng CMake và Meson build systems
- Deploy ứng dụng lên embedded board

### 11.1 Thiết lập môi trường

```bash
# Tạo project structure
mkdir -p ~/embedded-app/{src,include,build}
cd ~/embedded-app

# Tạo toolchain file
cat > toolchain-arm.cmake << 'EOF'
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER arm-linux-gnueabihf-g++)
set(CMAKE_Fortran_COMPILER arm-linux-gnueabihf-gfortran)

# Sysroot
set(CMAKE_SYSROOT /path/to/rootfs)
set(CMAKE_FIND_ROOT_PATH /path/to/rootfs)

# Search in target sysroot first
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
EOF
```

### 11.2 Build với CMake

**CMakeLists.txt:**

```cmake
cmake_minimum_required(VERSION 3.18)
project(myapp C)

# C standard
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Compiler flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra")

# Find packages
find_package(PkgConfig REQUIRED)
pkg_check_modules(LIBMNL REQUIRED libmnl)

# Include directories
include_directories(
    ${CMAKE_SOURCE_DIR}/include
    ${LIBMNL_INCLUDE_DIRS}
)

# Executable
add_executable(myapp
    src/main.c
    src/config.c
    src/network.c
)

# Link libraries
target_link_libraries(myapp
    ${LIBMNL_LIBRARIES}
    m
)

# Install
install(TARGETS myapp DESTINATION bin)
install(FILES config.conf DESTINATION etc)
```

**Build:**

```bash
mkdir build && cd build
cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain-arm.cmake ..
make -j$(nproc)
make install DESTDIR=~/rootfs
```

### 11.3 Build với Meson

**meson.build:**

```meson
project('myapp', 'c',
    version: '1.0.0',
    default_options: [
        'warning_level=2',
        'optimization=2',
        'b_lto=false'
    ]
)

# Dependencies
libmnl = dependency('libmnl', required: true)
threads = dependency('threads')

# Include directories
inc = include_directories('include')

# Executable
myapp = executable('myapp',
    'src/main.c',
    'src/config.c',
    'src/network.c',
    dependencies: [libmnl, threads],
    include_directories: inc,
    install: true
)

# Tests
test('basic', myapp)
```

**Cross file (cross.txt):**

```ini
[binaries]
c = '/opt/toolchain/bin/arm-linux-gnueabihf-gcc'
cpp = '/opt/toolchain/bin/arm-linux-gnueabihf-g++'
ar = '/opt/toolchain/bin/arm-linux-gnueabihf-ar'
pkgconfig = '/opt/toolchain/bin/arm-linux-gnueabihf-pkg-config'

[host_machine]
system = 'linux'
cpu_family = 'arm'
cpu = 'armv7'
endian = 'little'
```

**Build:**

```bash
# Native build (testing)
meson setup build-native
meson compile -C build-native
meson test -C build-native

# Cross-compile
meson setup build --cross-file cross.txt
meson compile -C build
meson install -C build --destdir ~/rootfs
```

### 11.4 Ví dụ: TCP Server đơn giản

**main.c:**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define PORT 8888
#define BUFFER_SIZE 1024

int main(int argc, char *argv[]) {
    int server_fd, client_fd;
    struct sockaddr_in server_addr, client_addr;
    char buffer[BUFFER_SIZE];
    socklen_t addr_len = sizeof(client_addr);

    // Create socket
    server_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (server_fd < 0) {
        perror("socket failed");
        return 1;
    }

    // Set socket options (reuse address)
    int opt = 1;
    setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    // Configure server address
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(PORT);

    // Bind
    if (bind(server_fd, (struct sockaddr *)&server_addr,
             sizeof(server_addr)) < 0) {
        perror("bind failed");
        close(server_fd);
        return 1;
    }

    // Listen
    if (listen(server_fd, 5) < 0) {
        perror("listen failed");
        close(server_fd);
        return 1;
    }

    printf("Server listening on port %d\n", PORT);

    // Accept and handle connections
    while (1) {
        client_fd = accept(server_fd,
                          (struct sockaddr *)&client_addr,
                          &addr_len);
        if (client_fd < 0) {
            perror("accept failed");
            continue;
        }

        printf("Client connected: %s:%d\n",
               inet_ntoa(client_addr.sin_addr),
               ntohs(client_addr.sin_port));

        // Read from client
        ssize_t n = read(client_fd, buffer, BUFFER_SIZE - 1);
        if (n > 0) {
            buffer[n] = '\0';
            printf("Received: %s\n", buffer);

            // Send response
            const char *response = "Message received!";
            write(client_fd, response, strlen(response));
        }

        close(client_fd);
        printf("Client disconnected\n");
    }

    close(server_fd);
    return 0;
}
```

**CMakeLists.txt:**

```cmake
cmake_minimum_required(VERSION 3.18)
project(tcpserver C)

add_executable(tcpserver src/main.c)

# Enable POSIX for some embedded systems
target_link_libraries(tcpserver pthread)

install(TARGETS tcpserver DESTINATION bin)
```

### 11.5 Deploy lên Board

```bash
# Copy binary và dependencies
rsync -avz --progress \
    ~/rootfs/ \
    root@192.168.1.100:/

# Hoặc dùng scp
scp tcpserver root@192.168.1.100:/tmp/

# Chạy trên board
./tcpserver
```

### 11.6 Debug khi thiếu thư viện

```bash
# Trên host: Kiểm tra dependencies
arm-linux-gnueabihf-ldd tcpserver
# Output:
#     libm.so.6 => /opt/rootfs/lib/libm.so.6
#     libc.so.6 => /opt/rootfs/lib/libc.so.6

# Nếu thiếu thư viện, copy vào rootfs
sudo cp /opt/toolchain/arm-linux-gnueabihf/lib/*.so* /path/to/rootfs/lib/

# Rebuild ld cache trên board
ldconfig
```

### Bài tập Chương 11

**Bài 11.1:** Viết một application đọc GPIO button và bật/tắt LED:
```c
// Pseudocode
while (1) {
    if (read_button() == PRESSED) {
        toggle_led();
    }
    sleep(100ms);
}
```

**Bài 11.2:** Viết một MQTT client đơn giản publish temperature data lên broker.

---

## Chương 12: Debugging

### Mục tiêu học tập
- Sử dụng GDB để debug ứng dụng
- Thiết lập remote debugging với gdbserver
- Sử dụng Valgrind để phát hiện memory errors

### 12.1 GDB Fundamentals

#### Compile với debug symbols

```bash
# Cần -g để có debug info
arm-linux-gnueabihf-gcc -g -O0 -o myapp main.c

# Với gdbserver trên board
scp myapp root@192.168.1.100:/tmp/
```

#### Commands cơ bản

| Command | Short | Mô tả |
|---------|-------|-------|
| `break <location>` | `b` | Đặt breakpoint |
| `run <args>` | `r` | Chạy chương trình |
| `continue` | `c` | Tiếp tục sau breakpoint |
| `next` | `n` | Step over (không vào function) |
| `step` | `s` | Step into (vào function) |
| `print <expr>` | `p` | In giá trị biến |
| `print *ptr` | | Dereference pointer |
| `backtrace` | `bt` | Xem call stack |
| `info threads` | | Xem threads |
| `thread <n>` | | Chuyển sang thread n |
| `list` | `l` | Xem source code |
| `finish` | | Chạy đến khi function return |
| `quit` | `q` | Thoát |

#### Ví dụ debugging session

```bash
# Trên host
arm-linux-gnueabihf-gdb myapp

(gdb) break main
(gdb) break process_data
(gdb) run

# Khi dừng ở breakpoint
(gdb) print counter
$1 = 0
(gdb) next
(gdb) print counter
$2 = 1
(gdb) step          # vào process_data
(gdb) print buffer
$3 = "hello"
(gdb) bt           # xem call stack
#0  process_data (buf=0xbefff8d4 "") at main.c:25
#1  0x0001048c in main (argc=1, argv=0xbefffea4) at main.c:45

(gdb) continue
(gdb) quit
```

### 12.2 Remote Debugging với gdbserver

#### Setup trên Board

```bash
# Copy gdbserver (từ Buildroot hoặc compile)
# Hoặc build gdbserver riêng
scp gdbserver root@192.168.1.100:/tmp/

# Chạy gdbserver
gdbserver :2345 ./myapp

# Output:
# Process ./myapp created; pid = 1234
# Listening on port 2345
```

#### Connect từ Host

```bash
# Start GDB với cross-compiled binary
arm-linux-gnueabihf-gdb myapp

(gdb) target remote 192.168.1.100:2345

# Debug như bình thường
(gdb) break main
(gdb) continue

# Đợi board process exit hoặc detach
(gdb) detach
(gdb) quit
```

#### Debug running process

```bash
# Trên board: attach vào process đang chạy
gdbserver --attach :2345 1234   # PID 1234

# Hoặc
gdbserver :2345 --attach 1234

# Trên host
arm-linux-gnueabihf-gdb myapp
(gdb) target remote 192.168.1.100:2345
(gdb) bt    # Xem stack của process đang chạy
```

### 12.3 Core Dump Debugging

#### Enable core dumps trên board

```bash
# Set ulimit
ulimit -c unlimited

# Set core pattern
echo '/tmp/core.%e.%p.%t' > /proc/sys/kernel/core_pattern

# Hoặc với systemd
mkdir -p /etc/sysctl.d
echo 'kernel.core_pattern = /tmp/core.%e.%p.%t' > \
    /etc/sysctl.d/core.conf
sysctl -p /etc/sysctl.d/core.conf
```

#### Analyze core dump trên host

```bash
# Copy core dump
scp root@192.168.1.100:/tmp/core.* ./

# Analyze
arm-linux-gnueabihf-gdb myapp core.file

(gdb) bt              # Full backtrace
(gdb) info registers  # Register values
(gdb) x/16x $sp       # Stack content
(gdb) print variables # Variable values
```

### 12.4 Valgrind (Memory Debugging)

Valgrind chạy trên synthetic CPU, phát hiện memory errors.

```bash
# Build valgrind cho ARM
git clone https://sourceware.org/git/valgrind.git
cd valgrind
./autogen.sh
./configure --host=arm-linux-gnueabihf --prefix=/opt/valgrind
make -j$(nproc)
make install

# Copy sang board
rsync -avz /opt/valgrind/ root@192.168.1.100:/opt/valgrind/

# Copy valgrind .so files sang board
rsync -avz /opt/valgrind/lib/valgrind/ root@192.168.1.100:/opt/valgrind/lib/

# Chạy trên board
valgrind --leak-check=full ./myapp
```

**Output Valgrind:**

```
==1234== Memcheck, a memory error detector
==1234== Copyright (C) 2002-2024, and GNU GPL'd, by Julian Seward et al.
==1234==
==1234== Invalid write of size 4
==1234==    at 0x4007B4: process_data (main.c:35)
==1234==    by 0x4008A2: main (main.c:50)
==1234==
==1234== 1 errors from 1 contexts (suppressed: 0 from 0)
==1234==
==1234== HEAP SUMMARY:
==1234==   in use at exit: 0 bytes in 0 blocks
==1234==   total heap usage: 10 allocs, 10 frees, 2,048 bytes allocated
==1234==
==1234== All heap blocks were freed -- no leaks are possible
```

### 12.5 Debug Kernel Modules

```bash
# Trên board: load module với debug info
insmod mymodule.ko

# Trên host: attach vào kernel module
arm-linux-gnueabihf-gdb \
    /lib/modules/$(uname -r)/kernel/mymodule.ko

(gdb) add-symbol-file /path/to/mymodule.ko 0xffffffc0000000

(gdb) break my_function
(gdb) continue

# Trigger function từ userspace
echo 1 > /sys/class/mymodule/trigger

(gdb) bt    # Kernel stack trace
```

### Bài tập Chương 12

**Bài 12.1:** Debug một chương trình C có lỗi buffer overflow:

```c
// bug.c - có bug intentional
#include <stdio.h>
#include <string.h>

void vulnerable(char *input) {
    char buffer[64];
    strcpy(buffer, input);  // Buffer overflow!
    printf("Buffer: %s\n", buffer);
}

int main(int argc, char *argv[]) {
    vulnerable(argv[1]);
    return 0;
}
```

Chạy với argument dài và debug với GDB để xác định lỗi.

**Bài 12.2:** Sử dụng Valgrind để phát hiện memory leak trong chương trình.

---

## Chương 13: Tracing và Profiling

### Mục tiêu học tập
- Sử dụng strace để trace system calls
- Dùng perf để profile performance
- Sử dụng ftrace để trace kernel functions

### 13.1 strace (System Call Tracer)

#### Cài đặt

```bash
# Cross-compile strace
git clone https://github.com/strace/strace.git
cd strace
./bootstrap
./configure --host=arm-linux-gnueabihf --prefix=/opt/strace
make -j$(nproc)
make install

# Copy sang board
rsync -avz /opt/strace/ root@192.168.1.100:/opt/
```

#### Sử dụng cơ bản

```bash
# Trace tất cả system calls
strace ./myapp

# Trace child processes (fork/vfork)
strace -f ./myapp

# Trace running process
strace -p 1234

# Summary count
strace -c ./myapp

# Filter by call type
strace -e trace=open,read,write,close ./myapp
strace -e trace=network ./myapp
strace -e trace=signal ./myapp
strace -e trace=ipc ./myapp

# Timestamp
strace -t ./myapp        # Thời gian mỗi call
strace -tt ./myapp       # Microseconds
strace -T ./myapp        # Thời gian trong ngoặc
```

**Output example:**

```
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
open("/lib/arm-linux-gnueabihf/libc.so.6", O_RDONLY|O_CLAREFILE) = 3
read(3, "\177ELF\2\1\1\0", 832) = 832
open("/proc/meminfo", O_RDONLY) = 3
write(1, "Hello, World!\n", 13) = 13
exit_group(0)                          = ?
+++ exited with 0 +++
```

### 13.2 perf (Performance Counters)

#### Cài đặt

```bash
# Trong Buildroot
make menuconfig
# → Toolchain → gdb → Enable

# Hoặc cài riêng
# perf thường nằm trong linux-tools
```

#### Commands

```bash
# CPU counters summary
perf stat ./myapp

# Sample với call graph
perf record -g ./myapp
perf report

# Specific events
perf stat -e cycles,instructions,cache-misses ./myapp
perf stat -e 'syscalls:sys_enter_read' -e 'syscalls:sys_exit_read' ./myapp

# Hardware counters
perf stat -e cycles:u -e cycles:k ./myapp    # Userspace/kernel cycles
perf stat -e cache-references -e cache-misses ./myapp

# List available events
perf list
perf list 'hardware'
perf list 'software'
perf list 'tracepoint'
```

**Output perf stat:**

```
Performance counter stats for './myapp':

       1,234,567   cycles               #    0.00 GHz
         567,890   instructions         #    0.46  insn per cycle
          12,345   cache-references
           1,234   cache-misses         #   10.0% of all cache refs
               45   branch-misses       #    0.01% of all branches

       0.001234567 seconds time elapsed
```

### 13.3 ftrace (Kernel Tracing)

#### Setup

```bash
# Mount tracefs
mount -t tracefs nodev /sys/kernel/tracing

# Kiểm tra
ls /sys/kernel/tracing/
```

#### Tracers có sẵn

```bash
# Xem available tracers
cat /sys/kernel/tracing/available_tracers
# Output: function function_graph wakeup_dl preemptirqsoff ...

# Xem current tracer
cat /sys/kernel/tracing/current_tracer
```

#### Function tracing

```bash
# Bật function tracer
echo function > /sys/kernel/tracing/current_tracer

# Xem output
cat /sys/kernel/tracing/trace | head -20

# Tắt
echo nop > /sys/kernel/tracing/current_tracer
```

#### Function graph

```bash
# Hiển thị call hierarchy
echo function_graph > /sys/kernel/tracing/current_tracer

# Filter theo function cụ thể
echo 'schedule*' > /sys/kernel/tracing/set_ftrace_filter
```

#### Event tracing

```bash
# Xem available events
ls /sys/kernel/tracing/events/

# Enable event
echo 1 > /sys/kernel/tracing/events/sched/sched_wakeup/enable

# Hoặc dùng perf
perf sched record -a sleep 5
perf sched map

# Analyze with kernelshark
kernelshark
```

### 13.4 ltrace (Library Call Tracer)

```bash
# Build ltrace cho ARM
git clone https://github.com/strace/ltrace.git
cd ltrace
./autogen.sh
./configure --host=arm-linux-gnueabihf
make -j$(nproc)

# Sử dụng
ltrace ./myapp
ltrace -c ./myapp              # Summary
ltrace -S ./myapp              # System calls too
ltrace -f -e 'libc.so*' ./myapp  # Filter library
```

### 13.5 gprof (Application Profiler)

#### Compile với profiling

```bash
# Cần -pg flag
arm-linux-gnueabihf-gcc -pg -g -O2 -o myapp main.c utils.c

# Chạy (sẽ tạo gmon.out)
./myapp

# Analyze
arm-linux-gnueabihf-gprof myapp gmon.out > analysis.txt
```

**Output gprof:**

```
Flat profile:
Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total
 time   seconds   seconds    calls  ms/call  ms/call  name
 25.00      0.25     0.25       100     2.50     5.00  process_data
 20.00      0.45     0.20        10    20.00    25.00  init_system
 15.00      0.60     0.15     10000     0.02     0.02  checksum

                    Call graph
index % time    self  children    called     name
                                                 <spontaneous>
[1]     60.0    0.00    0.60                 main
                0.25    0.20     100/100       process_data [2]
```

### Bài tập Chương 13

**Bài 13.1:** Sử dụng strace để xem một chương trình đơn giản mở file và đọc:
```bash
strace -e trace=open,read,write,close cat /etc/hostname
```

**Bài 13.2:** Benchmark một function với perf để tìm bottleneck:
```bash
perf stat -e cycles,instructions,cache-misses \
    ./myapp
```

**Bài 13.3:** Trace kernel functions liên quan đến I2C:
```bash
echo 'i2c_*' > /sys/kernel/tracing/set_ftrace_filter
echo function > /sys/kernel/tracing/current_tracer
cat /sys/kernel/tracing/trace | head -50
```

---

## Phụ lục: Công thức và Cheat Sheet

### A.1 Common Commands Quick Reference

```bash
# Toolchain
arm-linux-gnueabihf-gcc -v              # Kiểm tra version
arm-linux-gnueabihf-gcc -print-sysroot  # Sysroot path
arm-linux-gnueabihf-gcc -dumpmachine     # Target triple

# Kernel
make zImage                    # Build ARM kernel
make modules                   # Build modules
make modules_install           # Install modules
make clean                     # Clean build
make distclean                 # Full clean

# Buildroot
make menuconfig                # Configure
make                           # Build
make savedefconfig             # Save defconfig

# U-Boot
make <board>_defconfig         # Configure
make                           # Build
```

### A.2 Kernel Boot Parameters Reference

| Parameter | Example | Mô tả |
|-----------|---------|--------|
| `console` | `ttyS0,115200` | Console device |
| `root` | `/dev/mmcblk0p2` | Root device |
| `rootfstype` | `ext4` | Root filesystem type |
| `rootwait` | (no value) | Wait for root device |
| `rw` / `ro` | | Mount mode |
| `init` | `/sbin/init` | Init program |
| `ip` | `192.168.1.100::...` | IP configuration |
| `nfsroot` | `192.168.1.1:/nfs/root` | NFS root |
| `mem` | `512M` | Memory size |
| `panic` | `5` | Panic timeout |
| `cgroup_disable` | `memory` | Disable cgroups |

### A.3 GPIO Sysfs Reference

```bash
# Export GPIO
echo 49 > /sys/class/gpio/export

# Direction
echo in > /sys/class/gpio/gpio49/direction
echo out > /sys/class/gpio/gpio49/direction

# Read/Write
cat /sys/class/gpio/gpio49/value      # Read
echo 1 > /sys/class/gpio/gpio49/value # Write

# Unexport
echo 49 > /sys/class/gpio/unexport
```

### A.4 Common Mount Options

```bash
# Block device
mount -t ext4 /dev/mmcblk0p2 /mnt

# NFS
mount -t nfs 192.168.1.1:/nfs/root /mnt

# tmpfs
mount -t tmpfs -o size=50% tmpfs /mnt

# Overlay
mount -t overlay overlay \
    -o lowerdir=/ro,upperdir=/rw,workdir=/work \
    /merged

# Loop device
mount -o loop image.ext4 /mnt
```

---

## Tài liệu tham khảo

1. **Bootlin Training Materials**: https://bootlin.com/training/embedded-linux
2. **Linux Kernel Documentation**: https://www.kernel.org/doc/html/latest/
3. **Buildroot Manual**: https://buildroot.org/docs.html
4. **Yocto Project Documentation**: https://docs.yoctoproject.org
5. **U-Boot Documentation**: https://docs.u-boot.org
6. **Device Tree Reference**: https://www.devicetree.org/specifications/

---

> *"The Linux kernel is the greatest collaborative software project in history."*  
> — Linus Torvalds

---

**Giấy phép:** Creative Commons Attribution-ShareAlike 3.0  
**Nguồn:** Tổng hợp từ Bootlin - Embedded Linux System Development Training  
