# Embedded Linux System Development Training

> **Nguồn:** Bootlin (trước đây là Free Electrons)  
> **Bản quyền:** Creative Commons BY-SA 3.0  
> **Cập nhật mới nhất:** April 17, 2026  
> **Website:** https://bootlin.com/training/embedded-linux

---

## Mục lục

1. [Giới thiệu về Bootlin](#1-giới-thiệu-về-bootlin)
2. [Thông tin khóa học](#2-thông-tin-khóa-học)
3. [Phần 1: Giới thiệu Embedded Linux](#3-phần-1-giới-thiệu-embedded-linux)
4. [Phần 2: Toolchain Cross-compilation](#4-phần-2-toolchain-cross-compilation)
5. [Phần 3: Bootloader và Firmware](#5-phần-3-bootloader-và-firmware)
6. [Phần 4: Linux Kernel](#6-phần-4-linux-kernel)
7. [Phần 5: Root Filesystem](#7-phần-5-root-filesystem)
8. [Phần 6: BusyBox](#8-phần-6-busybox)
9. [Phần 7: Truy cập Hardware Devices](#9-phần-7-truy-cập-hardware-devices)
10. [Phần 8: Block Filesystem](#10-phần-8-block-filesystem)
11. [Phần 9: Flash Storage và MTD](#11-phần-9-flash-storage-và-mtd)
12. [Phần 10: Cross-compiling Libraries và Applications](#12-phần-10-cross-compiling-libraries-và-applications)
13. [Phần 11: Embedded Build Systems](#13-phần-11-embedded-build-systems)
14. [Phần 12: Open Source Licenses](#14-phần-12-open-source-licenses)
15. [Phần 13: Embedded Linux Software Stacks](#15-phần-13-embedded-linux-software-stacks)
16. [Phần 14: Application Development](#16-phần-14-application-development)
17. [Phần 15: Debugging](#17-phần-15-debugging)
18. [Phần 16: Tracing và Profiling](#18-phần-16-tracing-và-profiling)
19. [Tài nguyên và Kết luận](#19-tài-nguyên-và-kết-luận)

---

## 1. Giới thiệu về Bootlin

### 1.1 Lịch sử và Tổ chức

- **Tên công ty:** Bootlin (trước đây là Free Electrons, đổi tên năm 2018)
- **Thành lập:** Năm 2004
- **Trụ sở:** France và Italy
- **Phạm vi:** Phục vụ khách hàng trên toàn thế giới
- **Chuyên môn:**
  - Embedded Linux
  - Linux Kernel
  - Embedded Linux Build Systems

### 1.2 Đóng góp Open Source

Bootlin là một trong những công ty đóng góp mạnh nhất cho Linux kernel:

- **Top 30** công ty đóng góp Linux trên toàn thế giới
- Đóng góp trong hầu hết các lĩnh vực liên quan đến hỗ trợ phần cứng
- Nhiều kỹ sư là maintainer của các subsystem/platform
- **9,000 patches** đã đóng góp
- Trang đóng góp: https://bootlin.com/community/contributions/kernel-contributions/

#### Các dự án khác:
- **Yocto Project:** Maintainer của tài liệu chính thức, tham gia QA
- **Buildroot:** Co-maintainer, **6,000 patches** đóng góp
- **U-Boot, OP-TEE, Barebox:** Đóng góp đáng kể
- **Tài liệu đào tạo hoàn toàn open-source**

### 1.3 Dịch vụ của Bootlin

- **Dịch vụ kỹ thuật (Engineering Services):** Tư vấn và phát triển
- **Khóa đào tạo (Training Courses):**
  - Khóa công khai online
  - Khóa dành riêng cho doanh nghiệp (online hoặc on-site)
  - Đăng ký: https://bootlin.com/training/embedded-linux

### 1.4 Tài nguyên trực tuyến

- Website: https://bootlin.com
- Engineering services: https://bootlin.com/engineering
- Training services: https://bootlin.com/training
- LinkedIn: https://www.linkedin.com/company/bootlin
- **Elixir** - Duyệt source Linux kernel trực tuyến: https://elixir.bootlin.com

---

## 2. Thông tin khóa học

### 2.1 Hardware được sử dụng trong khóa học

#### BeagleBone Black / BeagleBone Black Wireless
| Thành phần | Chi tiết |
|------------|----------|
| CPU | Texas Instruments AM335x (ARM Cortex-A8) |
| RAM | 512 MB |
| Storage | 4 GB eMMC on-board |
| Headers | 2 x 46 pins (I2C, SPI, UART...) |
| Giá | ~$55-$60 |

**Phụ kiện cần thiết:**
- MicroUSB cable
- USB Serial Cable - 3.3V (cho serial console)
- Nintendo Nunchuk with UEXT connector
- Breadboard jumper wires
- MicroSD card
- USB audio headset

#### STM32MP157
| Thành phần | Chi tiết |
|------------|----------|
| CPU | STM32MP157 (Dual Cortex-A7 + Cortex-M4) |
| RAM | 512 MB DDR3L |
| Kit | STM32MP157A-DK1, DK2, hoặc F-DK2 |

#### BeaglePlay
| Thành phần | Chi tiết |
|------------|----------|
| CPU | Texas Instruments AM625x (4x ARM Cortex-A53) |
| RAM | 2 GB |
| Storage | 16 GB eMMC |

#### STM32MP257
| Thành phần | Chi tiết |
|------------|----------|
| CPU | STM32MP257 (Dual Cortex-A35 + Cortex-M33) |
| RAM | 4 GB LPDDR4 |

#### IMX93 FRDM
| Thành phần | Chi tiết |
|------------|----------|
| CPU | NXP i.MX 93 (Dual ARM Cortex-A55 + Cortex-M33) |
| RAM | 2 GB LPDDR4 |
| Storage | 32 GB eMMC |

### 2.2 Yêu cầu chứng chỉ

1. Tham dự tất cả các buổi học
2. Đạt hơn 50% câu trả lời đúng ở bài kiểm tra cuối khóa
3. Bài quiz cuối phải hoàn thành trong vòng 2 tuần sau khi khóa học kết thúc
4. Chứng chỉ sẽ được gửi 2 tuần sau ngày kết thúc khóa học

---

## 3. Phần 1: Giới thiệu Embedded Linux

### 3.1 Lịch sử phần mềm tự do (Free Software)

| Năm | Sự kiện |
|-----|---------|
| 1983 | Richard Stallman sáng lập **GNU project** và khái niệm free software. Bắt đầu phát triển gcc, gdb, glibc |
| 1991 | Linus Torvalds khởi động dự án **Linux kernel** - một kernel hệ điều hành kiểu UNIX. Kết hợp với phần mềm GNU tạo thành hệ điều hành hoàn chỉnh **GNU/Linux** |
| 1995 | Linux ngày càng phổ biến trên các hệ thống server |
| 2000 | Linux ngày càng phổ biến trên các hệ thống embedded |
| 2008 | Linux ngày càng phổ biến trên thiết bị di động và điện thoại |
| 2012 | Linux có sẵn trên phần cứng giá rẻ, có thể mở rộng: Raspberry Pi, BeagleBone Black |

### 3.2 Free Software là gì?

Một chương trình được coi là **free software** khi license cung cấp cho tất cả người dùng **4 quyền tự do**:

1. **Quyền tự do 0:** Chạy phần mềm cho bất kỳ mục đích nào
2. **Quyền tự do 1:** Nghiên cứu và thay đổi phần mềm
3. **Quyền tự do 2:** Phân phối lại bản copy
4. **Quyền tự do 3:** Phân phối bản đã sửa đổi

> Các quyền này áp dụng cho cả sử dụng thương mại và phi thương mại. Điều này đồng nghĩa với việc source code phải có sẵn.

### 3.3 Embedded Linux là gì?

> **Embedded Linux là việc sử dụng Linux kernel và các thành phần open-source trong các hệ thống embedded.**

### 3.4 Ưu điểm của Linux và Open-Source trong Embedded Systems

#### Khả năng tái sử dụng (Ability to reuse components)
- Nhiều tính năng, giao thức và phần cứng được hỗ trợ
- Cho phép tập trung vào giá trị gia tăng của sản phẩm

#### Chi phí thấp (Low cost)
- Không có royalty theo đơn vị
- Công cụ phát triển miễn phí
- Chi phí triển khai Linux bao gồm thời gian và công sức

#### Toàn quyền kiểm soát (Full control)
- Bạn quyết định khi nào cập nhật thành phần
- Không bị phụ thuộc vào vendor (no vendor lock-in)
- Bảo vệ đầu tư của bạn

#### Dễ dàng test tính năng mới (Easy testing)
- Không cần đàm phán với vendor bên thứ ba
- Chỉ cần khám phá giải pháp mới từ cộng đồng

#### Chất lượng (Quality)
- Hệ thống xây dựng trên nền tảng chất lượng cao (kernel, compiler, C-library, utilities)
- Nhiều ứng dụng open-source có chất lượng tốt

#### Bảo mật (Security)
- Có thể truy vết nguồn gốc của tất cả thành phần
- Thực hiện đánh giá lỗ hổng độc lập

#### Hỗ trợ cộng đồng (Community support)
- Có thể nhận được hỗ trợ rất tốt từ cộng đồng
- Nếu tiếp cận với thái độ xây dựng

#### Tham gia cộng đồng (Participation)
- Cơ hội cộng tác với đồng nghiệp
- Vượt qua rào cản công ty

### 3.5 Ví dụ các hệ thống Embedded chạy Linux

#### Router không dây (Wireless routers)
- Hầu hết các router gia đình hiện đại chạy Linux (OpenWrt, DD-WRT)
- Ví dụ: Router dựa trên SoC như Broadcom, Qualcomm, MediaTek

#### Hệ thống Video
- Các thiết bị streaming video, smart TV
- DVR/NVR systems

#### Máy tính xe đạp (Bike computers)
- Thiết bị GPS cho xe đạp thông minh

#### Robot
- eduMIP robot - robot cân bằng sử dụng BeagleBone
- Drone và các hệ thống tự động hóa

#### Trong không gian (In space!)
- **SpaceX Starlink satellites** - Vệ tinh Starlink
- **SpaceX Falcon 9 và Falcon Heavy rockets**
- **Mars Ingenuity Helicopter** - Trực thăng trên sao Hỏa của NASA
  - Xem thêm: "Linux on Mars: How the Perseverance Rover and Ingenuity Helicopter Leveraged Linux" - Tim Canham (JPL, NASA)

### 3.6 Phần cứng cho hệ thống Linux

#### 3.6.1 Processor và Architecture

**Các kiến trúc được hỗ trợ:**

| Kiến trúc | Mô tả |
|-----------|-------|
| **x86 / x86-64** | PC platforms, multimedia, industrial |
| **ARM** | Hàng trăm SoC khác nhau (CPU + on-chip devices) |
| **RISC-V** | Kiến trúc mới với instruction set mở, từ cloud đến embedded |
| **PowerPC** | Chủ yếu ứng dụng real-time, công nghiệp |
| **MIPS** | Chủ yếu ứng dụng networking |
| **Microblaze (Xilinx)** | Soft core trên FPGA |
| **Nios II (Altera)** | Soft core trên FPGA |
| **ARC, m68k, Xtensa, SuperH** | Các kiến trúc khác |

**Lưu ý quan trọng:**
- Linux hỗ trợ cả kiến trúc có **MMU** và **không có MMU**
- Linux **KHÔNG** hỗ trợ các microcontroller nhỏ (8 hoặc 16 bit)
- Ngoài toolchain, bootloader và kernel, các thành phần khác thường là **architecture-independent**

#### 3.6.2 RAM và Storage

**RAM:**
- Hệ thống Linux cơ bản có thể hoạt động với **8 MB RAM**
- Hệ thống thực tế thường cần ít nhất **32 MB RAM**
- Phụ thuộc vào loại và kích thước ứng dụng

**Storage:**
- Hệ thống cơ bản có thể hoạt động với **4 MB storage**
- Thường cần nhiều hơn
- **Block storage:** SD/MMC/eMMC, USB mass storage, SATA
- **Raw flash storage:** NAND và NOR flash, với filesystem riêng

#### 3.6.3 Giao tiếp (Communication)

**Truyền thông buses được hỗ trợ:**
- I2C
- SPI
- 1-wire
- SDIO
- PCI
- USB
- CAN (chủ yếu automotive)

**Networking:**
- Ethernet, Wifi, Bluetooth, CAN
- IPv4, IPv6, TCP, UDP
- Firewalling, advanced routing, multicast

#### 3.6.4 Các loại Hardware Platform

| Loại | Mô tả |
|------|-------|
| **Evaluation platforms** | Từ vendor SoC, đắt nhưng nhiều peripherals, tốt cho phát triển |
| **System on Module (SoM)** | Board nhỏ chỉ có CPU/RAM/flash, dùng cho sản phẩm số lượng vừa |
| **Community platforms** | BeagleBone, Raspberry Pi - giá rẻ, sẵn sàng dùng |
| **Custom platform** | Tự thiết kế, schematics thường freely available |

---

## 4. Phần 2: Toolchain Cross-compilation

### 4.1 Khái niệm Cross-compilation Toolchain

**Định nghĩa:** Cross-compilation toolchain là bộ công cụ dịch (compiler) chạy trên workstation nhưng **sinh code cho target**.

**Ví dụ architecture tuple:**
- `arm-linux-gnueabihf` - ARMv7 hard-float
- `mips64el-linux-gnu` - MIPS 64-bit little-endian
- `arm-vendor-none-eabihf` - ARM EABI hard-float (bare-metal)

### 4.2 Các thành phần của Cross-compilation Toolchain

#### 4.2.1 Binutils

Bộ công cụ binary utilities:

| Công cụ | Chức năng |
|---------|-----------|
| `as` | Assembler |
| `ld` | Linker |
| `ar`, `ranlib` | Tạo và quản lý archive files |
| `objdump` | Hiển thị thông tin object file |
| `readelf` | Đọc ELF format information |
| `size` | Hiển thị kích thước các section |
| `nm` | Liệt kê symbols |
| `strings` | Hiển thị chuỗi trong binary |
| `objcopy` | Sao chép và chuyển đổi object files |
| `strip` | Loại bỏ symbols để giảm kích thước |

#### 4.2.2 GCC (GNU Compiler Collection)

Hỗ trợ nhiều ngôn ngữ:
- C
- C++
- Ada
- Fortran
- Java
- Objective-C
- Go

#### 4.2.3 Kernel Headers

Cung cấp:
- System calls interface
- Các constants
- Data structures
- Located in: `<linux/...>` và `<asm/...>`

#### 4.2.4 C Standard Library

**Giao diện giữa ứng dụng và kernel.**

### 4.3 Các lựa chọn C Library

| Library | License | Đặc điểm | Kích thước (armv7hf) |
|---------|---------|-----------|----------------------|
| **glibc** | LGPL | Performance-oriented, standards compliance | libc: 1.5 MB, libm: 432 KB |
| **uClibc-ng** | LGPL | Lightweight, highly configurable, hỗ trợ no-MMU | 712 KB |
| **musl** | MIT | Lightweight, fast, simple, tốt cho static executable | 748 KB |

**Khuyến nghị:**
- Bắt đầu với **glibc** để debug dễ dàng
- Chuyển sang **uClibc/musl** khi cần giảm kích thước

### 4.4 Các thư viện khác

- **Newlib:** Embedded C library
- **klibc:** Minimal C library cho initramfs

### 4.5 LLVM/Clang Alternatives

| Thành phần | Tool |
|------------|------|
| Compiler | Clang |
| Debugger | LLDB |
| Linker | LLD |

### 4.6 ABI (Application Binary Interface)

**Định nghĩa:** ABI định nghĩa calling conventions và cách tổ chức structures.

#### ARM ABIs:
- **EABI:** ARM EABI (soft-float)
- **EABIhf:** ARM EABI hard-float (hard-float ABI)

#### RISC-V ABIs:
- `ilp32` - 32-bit int/long/pointer
- `ilp32f` - + single-precision FP
- `ilp32d` - + double-precision FP
- `lp64` - 64-bit long/pointer
- `lp64f` - + single-precision FP
- `lp64d` - + double-precision FP

#### Floating Point Support:
- **Hard float:** Hardware FPU được sử dụng
- **Soft float:** Software emulation

#### CPU Optimization Flags:
```bash
-march=<arch>    # Target architecture
-mtune=<cpu>     # CPU-specific tuning
-mcpu=<cpu>      # Combined -march and -mtune
```

### 4.7 Cách có được Toolchain

#### Building manually
Quá trình khó khăn với nhiều components phụ thuộc lẫn nhau.

#### Pre-compiled toolchains
- **Bootlin toolchains:** https://toolchains.bootlin.com
- **ARM GNU Toolchains:** https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads

#### Toolchain building utilities

**Crosstool-NG:**
```bash
git clone https://github.com/crosstool-ng/crosstool-ng
cd crosstool-ng
bootstrap && ./configure && make
make menuconfig
make
```

**Buildroot:**
```bash
make menuconfig
make
```

**Các build system khác:**
- PTXdist
- OpenEmbedded/Yocto

### 4.8 Cấu trúc thư mục Toolchain

```
<toolchain-install-dir>/
├── bin/
│   ├── arm-linux-gnueabihf-gcc
│   ├── arm-linux-gnueabihf-ld
│   └── ...
└── <arch-tuple>/
    └── sysroot/
        ├── lib/
        ├── usr/
        └── ...
```

---

## 5. Phần 3: Bootloader và Firmware

### 5.1 Các lựa chọn Bootloader

#### 5.1.1 GRUB (Grand Unified Bootloader)

- Cho **x86/x86-64**
- Hỗ trợ **legacy BIOS** và **UEFI**
- Cấu hình: `/boot/grub/grub.cfg`

#### 5.1.2 Syslinux

Thiên về network và removable media:

| Variant | Mục đích |
|---------|----------|
| `syslinux` | Boot from FAT filesystem |
| `pxelinux` | Network boot (PXE) |
| `isolinux` | CD-ROM boot |
| `extlinux` | ext2/3/4, Btrfs |

#### 5.1.3 systemd-boot

- Boot manager đơn giản cho **UEFI**
- Cấu hình: `/boot/loader/loader.conf`

#### 5.1.4 shim

- Bootloader tối thiểu cho **Secure Boot**
- Nằm giữa firmware và main bootloader

#### 5.1.5 U-Boot (Das U-Boot)

**Bootloader phổ biến nhất cho embedded:**

- Hỗ trợ: ARM, ARM64, RISC-V, PowerPC, MIPS, x86, NIOS-II, Microblaze
- Được sử dụng rộng rãi nhất trong embedded
- License: GPLv2
- Website: https://www.denx.de/wiki/U-Boot

#### 5.1.6 Barebox

- Bootloader thay thế
- Sử dụng **kconfig** giống kernel
- Device model rõ ràng
- Website: https://www.barebox.org

### 5.2 Chi tiết về U-Boot

#### 5.2.1 Getting U-Boot

- **U-Boot upstream:** https://gitlab.denx.de/u-boot/u-boot
- **Vendor forks:** Nhiều vendor có nhánh riêng với hỗ trợ hardware cụ thể

#### 5.2.2 Configuration

U-Boot sử dụng **kconfig** system:

```bash
# Tìm defconfig
ls configs/*_defconfig

# Ví dụ
stm32mp15_trusted_defconfig
am335x_evm_defconfig

# Cấu hình
make <board>_defconfig
make menuconfig
```

#### 5.2.3 Compilation

```bash
# Với cross-compilation
make CROSS_COMPILE=arm-linux-gnueabihf-

# Parallel build
make -j$(nproc)
```

**Output files:**
- `u-boot.bin` - Main binary
- `MLO` - For some ARM boards (First-stage bootloader)
- `u-boot.img` - With image header

#### 5.2.4 SPL (Secondary Program Loader)

- Phiên bản stripped-down của U-Boot
- Dùng cho first-stage boot
- Tải main U-Boot từ storage

#### 5.2.5 U-Boot Commands

| Lệnh | Mô tả |
|------|-------|
| `help` | Hiển thị help |
| `version` | Phiên bản U-Boot |
| `bdinfo` | Board information |
| `printenv` | Hiển thị environment variables |
| `setenv <var> <value>` | Đặt biến môi trường |
| `saveenv` | Lưu environment |

**Memory commands:**
```bash
md <addr> <count>      # Display memory
mw <addr> <value>      # Write memory
mm <addr>              # Modify memory
```

**Storage commands:**
```bash
nand info/erase/read/write
mmc info/rescan/read/write
usb start/info/dev
```

**Filesystem commands:**
```bash
fatls mmc 0:1          # List FAT filesystem
fatload mmc 0:1 0x80000000 uImage   # Load file
ext2ls mmc 0:1 /       # List ext2/3/4 filesystem
ext4load mmc 0:1 0x80000000 boot/uImage
```

**Networking commands:**
```bash
ping <ip>              # Ping host
tftp 0x80000000 uImage # TFTP download
dhcp                   # DHCP client
```

**Boot commands:**
```bash
bootz <addr>           # Boot zImage (ARM)
booti <addr>          # Boot Image (ARM64)
bootm <addr>          # Boot multi-format image
```

#### 5.2.6 Environment Variables

```bash
# Ví dụ bootcmd
setenv bootcmd 'tftp 0x80000000 uImage; bootz 0x80000000'
saveenv
```

#### 5.2.7 FIT Image (Flat Image Tree)

Format image mới cho việc bundle nhiều images (kernel, dtb, ramdisk):

```bash
mkimage -f fit-image.its fit-image.itb
```

#### 5.2.8 Generic Distro Boot

Cho phép boot theo cách standard:
- Tìm `extlinux.conf` trên storage
- Hoặc boot qua network với standard boot flow

#### 5.2.9 TFTP Setup

```bash
# Server side (host)
# Cài đặt tftpd-hpa (Ubuntu/Debian)
sudo apt install tftpd-hpa
sudo cp uImage /srv/tftp/
sudo chmod 644 /srv/tftp/uImage

# Trên U-Boot target
setenv ipaddr <target_ip>
setenv serverip <host_ip>
tftp 0x80000000 uImage
```

### 5.3 Trusted Firmware

#### 5.3.1 ARM TrustZone Architecture

| Exception Level | Component |
|----------------|-----------|
| **EL3** | Secure firmware (TF-A BL31) |
| **EL2** | Hypervisors (optional) |
| **EL1** | Linux kernel |
| **EL0** | User-space applications |

#### 5.3.2 TF-A (Trusted Firmware-A)

Reference implementation cho:
- **ARMv7-A:** ARMv7-A Trusted Firmware
- **ARMv8-A:** ARMv8-A Trusted Firmware-A

**Build cho STM32MP1:**
```bash
make PLAT=stm32mp1 ARCH=aarch32 ARM_TF_A平台=arm-linux-gnueabihf-
```

#### 5.3.3 OP-TEE

- Trusted OS cho secure world
- Chạy trong TrustZone alongside Linux

#### 5.3.4 RISC-V SBI (Supervisor Binary Interface)

Giao diện giữa M-mode và S-mode:

#### 5.3.5 OpenSBI

- Reference SBI implementation cho RISC-V
- Thay thế cho proprietary firmwares

### 5.4 Boot Sequences

#### Boot sequence cho **TI AM335x** (BeagleBone Black):
```
ROM Code → MLO (SPL) → U-Boot (main) → Linux Kernel → Root Filesystem
```

#### Boot sequence cho **NXP i.MX6**:
```
ROM → Boot Firmware → U-Boot → Kernel
```

#### Boot sequence cho **STM32MP1**:
```
ROM Code (BSEC) → TF-A (BL2) → OP-TEE (optional) → U-Boot (SPL) → U-Boot
```

#### Boot sequence cho **Allwinner ARMv8**:
```
BROM → FEL/UEFI/Fastboot → U-Boot → Kernel
```

### 5.5 FIP (Firmware Image Package)

Format đóng gói firmware images:

**Ví dụ cho STM32MP1:**
```bash
# Tạo FIP
./tools/mkimage -T fip -d <bl2.bin>:<nt_fw.bin>:<tbst-fw.bin>:<dfu.bin> \
    u-boot.dtb fip.bin
```

**Partition layout cho STM32MP1:**
| Partition | Nội dung | Kích thước |
|-----------|----------|------------|
| fsbl1 | TF-A BL2 | 256 KB |
| fsbl2 | Backup FSBL | 256 KB |
| ssbl | U-Boot + env | 2 MB |
| bootfs | Kernel + DTB | |
| rootfs | Root filesystem | |

---

## 6. Phần 4: Linux Kernel

### 6.1 Vai trò chính của Linux Kernel

1. **Quản lý hardware resources**
   - CPU time
   - Memory
   - I/O devices

2. **Cung cấp portable, architecture-independent APIs**

3. **Xử lý concurrent access** đến hardware resources

4. **System calls interface**
   - ~400 system calls
   - Cách chính user-space tương tác với kernel

5. **Pseudo-filesystems**
   - `/proc` - Process information, system parameters
   - `/sys` - System and kernel objects

### 6.2 Linux Kernel Versioning

**Lịch sử phiên bản:**

| Thời gian | Version | Ghi chú |
|-----------|---------|---------|
| 1991-2003 | 1.x → 2.4.x | Development phase |
| 2003 | **2.6.x** | Long-term development series |
| 2011 | 3.x | Renumbering (marketing) |
| 2015 | 4.x | Tiếp tục series |
| 2019 | 5.x | Stable releases |
| 2026 | **6.x** | Current series |
| 2026 (Mar/Apr) | **7.0** | Major new version |

**Chu kỳ phát hành:**
- **Stable releases:** Mỗi ~10 tuần
- **LTS (Long Term Support):** 6.6, 6.1, 5.10, 5.15, 5.4, 4.19, 4.14, 4.9, 4.4

### 6.3 Kernel Source

**Repository chính thức:**
```
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
```

**Kích thước source (v5.18):**
- ~80,000 files
- ~35 triệu dòng code
- ~1.3 GiB

**Cấu trúc thư mục:**

| Thư mục | % | Mô tả |
|---------|---|-------|
| `drivers/` | 61.1% | Device drivers |
| `arch/` | 11.6% | Architecture-specific code |
| `fs/` | 4.4% | Filesystems |
| `net/` | 3.7% | Networking |
| `kernel/` | 1.3% | Core kernel code |
| `mm/` | 2.5% | Memory management |
| `crypto/` | 1.3% | Cryptographic API |
| `scripts/` | 1.1% | Build and utility scripts |
| `include/` | 3.4% | Header files |

### 6.4 Kernel Configuration

#### Kconfig System

Cấu hình kernel với **hàng nghìn options** cho:
- Device drivers
- Filesystems
- Networking protocols
- Security options

**Option types:**
```kconfig
config <SYMBOL>
    bool "description"           # boolean: y/n
    tristate "description"       # tri-state: n/m/y (module)
    int "description"             # integer value
    hex "description"             # hexadecimal value
    string "description"          # string value
    select <FEATURE>              # auto-select dependency
    depends on <EXPR>             # dependency expression
```

**Configuration interfaces:**
```bash
make menuconfig       # Ncurses UI
make xconfig          # Qt-based GUI
make nconfig          # New ncurses UI
make gconfig          # GTK-based GUI
```

#### Default Configurations

```bash
# Xem các defconfig có sẵn
ls arch/<arch>/configs/*_defconfig

# Sử dụng defconfig
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- <board>_defconfig

# Cập nhật cấu hình từ kernel mới
make ARCH=arm oldconfig
```

#### Example: ARM Configuration

```bash
# Cấu hình cho BeagleBone Black
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bb.org_defconfig

# Hoặc sử dụng multi_v7 defconfig
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- multi_v7_defconfig
```

### 6.5 Compiling Kernel

#### Basic compilation

```bash
# Sequential build
make ARCH=<arch> CROSS_COMPILE=<tuple>-

# Parallel build (recommended)
make -j$(nproc) ARCH=<arch> CROSS_COMPILE=<tuple>-
```

#### Caching builds

```bash
# Sử dụng ccache để tăng tốc rebuild
export CROSS_COMPILE="ccache arm-linux-gnueabihf-"
make -j$(nproc)
```

#### Build outputs

| File | Mô tả |
|------|-------|
| `vmlinux` | Raw ELF kernel image (uncompressed) |
| `arch/<arch>/boot/Image` | Raw binary |
| `zImage` | Compressed ARM kernel (with decompressor) |
| `bzImage` | Big zImage (x86 compressed kernel) |

#### Installing modules

```bash
# Cài đặt modules
sudo make ARCH=<arch> INSTALL_MOD_PATH=/path/to/rootfs modules_install
```

### 6.6 Kernel Command Line

Truyền parameters cho kernel khi boot:

```bash
# Ví dụ bootargs trong U-Boot
setenv bootargs console=ttyS0,115200 root=/dev/mmcblk0p2 rootwait

# Các tham số phổ biến
root=<device>              # Root filesystem device
console=<tty>              # Console device
init=<program>             # Init program (default: /sbin/init)
```

### 6.7 Kernel Logging

```bash
# Xem kernel log
dmesg

# Xem real-time
dmesg -w

# Đọc từ /dev/kmsg
cat /dev/kmsg
```

---

## 7. Phần 5: Root Filesystem

### 7.1 Khái niệm Filesystem

**Filesystem** tổ chức dữ liệu thành **directories** và **files**.

**Cơ chế mount/unmount:**
- Mount: Gắn filesystem vào cây thư mục
- Mount point: Thư mục nơi filesystem được gắn

### 7.2 Root Filesystem

**Root filesystem (`/`):**
- Được mount bởi kernel qua `root=` option
- Chứa tất cả system files và applications

**Các vị trí có thể của root filesystem:**

| Nguồn | Thiết bị | Ví dụ |
|--------|----------|-------|
| Block device | `/dev/sda1`, `/dev/mmcblk0p2` | SD card, eMMC, SATA |
| NFS | `192.168.1.1:/nfs/root` | Network mount |
| initramfs | RAM-based | Initial root |

### 7.3 Mounting từ Block Device

```bash
# Kernel command line
root=/dev/mmcblk0p2 rootwait
```

| Thiết bị | Ý nghĩa |
|----------|---------|
| `/dev/sdXY` | SCSI/SATA (X=disk, Y=partition) |
| `/dev/mmcblkXpY` | MMC/SD (X=device, Y=partition) |
| `/dev/nvmeXnYpZ` | NVMe |
| `/dev/mtdblockX` | MTD block device |

### 7.4 NFS (Network File System) Mounting

Cho phép boot qua network từ host:

#### Host setup

```bash
# Cài đặt NFS server
sudo apt install nfs-kernel-server

# Cấu hình /etc/exports
/nfs/root *(rw,sync,no_subtree_check,no_root_squash)

# Export
sudo exportfs -ra
```

#### Kernel configuration

```
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_ROOT_NFS=y
CONFIG_IP_PNP=y
CONFIG_NETWORK_FILESYSTEMS=y
```

#### Boot parameters

```
root=/dev/nfs nfsroot=<server>:<path>,<options> ip=<client-ip>:<server-ip>:<gw>:<mask>:<hostname>:<device>
```

### 7.5 initramfs

**initramfs** là **compressed CPIO archive** được unpack vào RAM.

**Ưu điểm:**
- Không cần bootloader/kernel hỗ trợ filesystem cụ thể
- Có thể chứa drivers cần thiết để mount real root

**Tạo initramfs đơn giản:**

```bash
# Tạo directory structure
mkdir -p initramfs/{bin,sbin,etc,proc,sys,lib}
cd initramfs

# Copy busybox
cp /path/to/busybox/_install/bin/* bin/

# Tạo init script
cat > init << 'EOF'
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
exec switch_root /mnt /sbin/init
EOF
chmod +x init

# Tạo CPIO archive
find . -cpio -o -H newc | gzip > ../initramfs.cpio.gz
```

### 7.6 Filesystem Hierarchy Standard (FHS)

**Cấu trúc thư mục chuẩn:**

| Thư mục | Mô tả |
|---------|-------|
| `/bin` | Essential user command binaries |
| `/boot` | Static boot files (kernel, bootloader) |
| `/dev` | Device files |
| `/etc` | Configuration files |
| `/home` | User home directories |
| `/lib` | Essential shared libraries |
| `/media` | Mount points for removable media |
| `/mnt` | Mount points for temporary filesystems |
| `/opt` | Optional/add-on software |
| `/proc` | Process and system info (pseudo-FS) |
| `/root` | Root user home directory |
| `/run` | Runtime data |
| `/sbin` | Essential system binaries |
| `/sys` | System and kernel info (pseudo-FS) |
| `/tmp` | Temporary files |
| `/usr` | Secondary hierarchy (bin, lib, share) |
| `/var` | Variable data (logs, spools) |

### 7.7 Pseudo-filesystems

#### 7.7.1 proc filesystem

**Mục đích:** Cung cấp process information và system parameters

```bash
# Mount proc
mount -t proc nodev /proc

# Ví dụ entries
/proc/cpuinfo     # CPU information
/proc/meminfo     # Memory information
/proc/uptime      # System uptime
/proc/<pid>/      # Per-process information
```

#### 7.7.2 sysfs filesystem

**Mục đích:** Represent buses, devices, và drivers

```bash
# Mount sysfs
mount -t sysfs nodev /sys

# Ví dụ entries
/sys/bus/         # Available buses
/sys/class/       # Device classes
/sys/devices/     # Device tree
/sys/block/       # Block devices
/sys/module/      # Loaded modules
```

---

## 8. Phần 6: BusyBox

### 8.1 Giới thiệu

**BusyBox** là "Swiss Army Knife of Embedded Linux" - một executable duy nhất cung cấp nhiều UNIX utilities.

**Lịch sử:**
- Được tạo năm **1995** cho Debian rescue disk (1.44 MB floppy)
- Ban đầu để nén nhiều utilities vào một floppy
- License: **GNU GPLv2**

**Kích thước:**
- <500 KB (statically compiled với uClibc)
- <1 MB (với glibc)

### 8.2 Alternatives

**Toybox:**
- BSD-licensed alternative
- Được sử dụng trong Android và Alpine Linux

### 8.3 Applets trong BusyBox

BusyBox cung cấp nhiều applets (được symlink):

| Applet | Mô tả |
|--------|-------|
| `init` | Init system |
| `sh` | Shell (ash) |
| `vi` | Text editor |
| `grep` | Pattern matching |
| `sed` | Stream editor |
| `awk` | Text processing |
| `tar` | Archive utility |
| `wget` | HTTP download |
| `cp`, `mv`, `rm` | File operations |
| `ls`, `cat`, `pwd` | Basic utilities |
| `mount`, `umount` | Mount operations |
| `telnetd`, `httpd` | Network daemons |
| `ntpd`, `httpd` | Time/server |

### 8.4 Configuration

```bash
# Default configuration (most features)
make defconfig

# Minimal configuration (almost nothing)
make allnoconfig

# Menu-driven configuration
make menuconfig
```

### 8.5 Installation

```bash
make install
```

**Kết quả:**
```
_install/
├── bin/
│   ├── busybox → busybox
│   ├── cat, cp, ls... (symlinks to busybox)
├── sbin/
│   ├── busybox → ../bin/busybox
│   ├── init, mdev... (symlinks)
└── usr/
    └── bin/
        └── busybox → ../../bin/busybox
```

### 8.6 Sử dụng

```bash
# Chạy một applet
busybox ls -la /

# Hoặc sử dụng symlink
ls -la /

# Xem danh sách applets
busybox --list
```

---

## 9. Phần 7: Truy cập Hardware Devices

### 9.1 Kernel Drivers và Software Stack

**Kiến trúc driver:**

```
┌─────────────────────────────┐
│     User-space Application   │
├─────────────────────────────┤
│       Library (glibc)        │
├─────────────────────────────┤
│     System Call Interface    │
├─────────────────────────────┤
│   Device Driver Subsystem    │
│   (character, block, network) │
├─────────────────────────────┤
│      Bus Controller Driver    │
│   (PCIe, USB, I2C, SPI...)   │
├─────────────────────────────┤
│        Hardware (SoC)         │
└─────────────────────────────┘
```

### 9.2 Kernel Subsystems

| Subsystem | Mô tả |
|-----------|-------|
| **Networking** | Ethernet, WiFi, Bluetooth drivers |
| **GPIO** | General Purpose Input/Output |
| **Video4Linux (V4L2)** | Video capture devices |
| **DRM/KMS** | Display, GPU drivers |
| **ALSA** | Audio devices |
| **IIO** | Industrial I/O (sensors) |
| **MTD** | Memory Technology Devices (flash) |
| **PWM** | Pulse Width Modulation |
| **Input** | Keyboards, mice, touchscreens |
| **Watchdog** | Watchdog timers |
| **RTC** | Real-time clocks |
| **Remoteproc** | Remote processor control |
| **Crypto** | Cryptographic algorithms |
| **hwmon** | Hardware monitoring |
| **Block layer** | Storage devices |

### 9.3 User-space Interfaces

#### 9.3.1 Device Nodes (`/dev/`)

**Character devices:** Truy cập character-by-character (serial, terminals)

**Block devices:** Random access (disks, storage)

```bash
# Tạo device node thủ công
mknod /dev/mynode c 250 0
mknod /dev/sda b 8 0
```

**Major/Minor numbers:**
- Major number: Loại device
- Minor number: Instance của device

#### 9.3.2 Dynamic Device Management

**devtmpfs:**
- Kernel tạo device nodes tự động
- Mount tại `/dev` ngay khi boot

**udev:**
- User-space daemon quản lý `/dev`
- Tạo device nodes theo rules
- Đặt permissions, symlinks

**mdev:**
- Lightweight alternative cho udev
- Thường dùng trong embedded

#### 9.3.3 sysfs Interface

```bash
# Xem GPIO
ls /sys/class/gpio/

# Xem I2C devices
ls /sys/bus/i2c/devices/

# Xem SPI devices
ls /sys/bus/spi/devices/
```

### 9.4 Kernel Modules

#### 9.4.1 Module Locations

Modules được cài đặt trong:
```
/lib/modules/<kernel-version>/
├── kernel/           # Native kernel modules
├── extra/            # Out-of-tree modules
├── updates/          # Updated modules
├── modules.dep       # Module dependencies
├── modules.alias     # Aliases for module loading
├── modules.symbols   # Symbol versions
└── modules.builtin  # Built-in modules
```

#### 9.4.2 Module Commands

```bash
# Liệt kê modules đã load
lsmod

# Thông tin module
modinfo <module.ko>

# Load module
insmod <module.ko>
insmod <module.ko> param=value

# Remove module
rmmod <module_name>

# Load với dependencies
modprobe <module_name>

# Remove với dependencies
modprobe -r <module_name>
```

#### 9.4.3 Module Dependencies

```bash
# Kiểm tra dependencies
modprobe -c | grep <module>

# Module dependency file
cat /lib/modules/$(uname -r)/modules.dep
```

### 9.5 Device Tree

#### 9.5.1 Mục đích

Mô tả phần cứng **non-discoverable** (không thể detect tự động qua bus).

**Nguồn gốc:** OpenFirmware (SPARC, PowerPC)

#### 9.5.2 Device Tree Compiler (dtc)

```bash
# Compile .dts to .dtb
dtc -I dts -O dtb -o device_tree.dtb device_tree.dts

# Decompile .dtb to .dts
dtc -I dtb -O dts -o device_tree.dts device_tree.dtb
```

#### 9.5.3 Device Tree Structure

```dts
/dts-v1/;

/ {
    compatible = "vendor,product";
    #address-cells = <1>;
    #size-cells = <1>;

    cpus {
        #address-cells = <1>;
        #size-cells = <0>;
        cpu@0 {
            device_type = "cpu";
            compatible = "arm,cortex-a7";
            reg = <0>;
        };
    };

    soc {
        #address-cells = <1>;
        #size-cells = <1>;
        compatible = "simple-bus";

        serial@40000000 {
            compatible = "st,stm32-usart";
            reg = <0x40000000 0x200>;
            status = "okay";
        };

        i2c@40013000 {
            compatible = "st,stm32f7-i2c";
            reg = <0x40013000 0x400>;
            #address-cells = <1>;
            #size-cells = <0>;

            eeprom@50 {
                compatible = "microchip,24c256";
                reg = <0x50>;
            };
        };
    };
};
```

#### 9.5.4 Important Properties

| Property | Mô tả |
|----------|-------|
| `compatible` | Driver matching (vendor,chip) |
| `reg` | Memory addresses, I2C addresses, SPI chip selects |
| `status` | `"okay"` hoặc `"disabled"` |
| `interrupts` | IRQ lines and configuration |
| `clocks` | Reference to clock providers |
| `gpio` | GPIO references |

#### 9.5.5 Device Tree Inheritance

```dts
/* Include common SoC definitions */
#include "stm32mp157.dtsi"

/ {
    model = "My Board";
    compatible = "myvendor,myboard", "st,stm32mp157";

    /* Board-specific overrides */
    &serial1 {
        status = "okay";
    };
};
```

### 9.6 USB và PCI (Discoverable Hardware)

```bash
# Liệt kê USB devices
lsusb

# Chi tiết USB
lsusb -v

# Liệt kê PCI devices
lspci

# Chi tiết PCI
lspci -v
```

---

## 10. Phần 8: Block Filesystem

### 10.1 Block vs Raw Flash

| Loại | Đặc điểm | Ví dụ |
|------|----------|-------|
| **Block device** | Random access, no erasing | Hard disks, SD cards, eMMC, SATA |
| **Raw flash** | Cần erase trước khi write | NOR, NAND flash |

### 10.2 Các Block Filesystem

#### 10.2.1 ext2

- **Legacy filesystem**
- Không có journaling
- **2038 date issue** (32-bit timestamp)
- Dùng cho boot partitions, SD cards

#### 10.2.2 ext4

- **Default cho nhiều distros**
- Journaling support
- Backward compatible với ext2/3
- Features:
  - Delayed allocation
  - Extents
  - Persistent pre-allocation
  - Transparent encryption
  - 1-second timestamps

```bash
# Tạo ext4
mkfs.ext4 /dev/sda1

# Với options
mkfs.ext4 -L rootfs -E root_owner=0:0 /dev/sda1

# Mount
mount -t ext4 /dev/sda1 /mnt
```

#### 10.2.3 XFS

- **Journaling filesystem**
- Variable block size
- Online growth/shrink
- High-performance for large files
- Metadata-intensive workloads

```bash
mkfs.xfs /dev/sda1
mount -t xfs /dev/sda1 /mnt
```

#### 10.2.4 Btrfs

- **Copy-on-write (COW)**
- Snapshots và clones
- Transparent compression (zlib, lzo, zstd)
- Subvolumes
- Integrated RAID
- Self-healing (checksums)

```bash
mkfs.btrfs /dev/sda1
mount -t btrfs /dev/sda1 /mnt

# Tạo subvolume
btrfs subvolume create /mnt/data

# Snapshot
btrfs subvolume snapshot /mnt /mnt/snapshot
```

#### 10.2.5 F2FS (Flash-Friendly File System)

- **Log-structured filesystem**
- Được thiết kế cho **SSD, eMMC, SD cards**
- LZO, LZ4, Zstd compression
- Flash-aware

```bash
mkfs.f2fs /dev/mmcblk0p2
mount -t f2fs /dev/mmcblk0p2 /mnt
```

#### 10.2.6 SquashFS

- **Read-only filesystem**
- **Highly compressed**
- Ideal cho kernel, read-only binaries
- **Best compression ratio**

```bash
# Tạo SquashFS
mksquashfs source_dir rootfs.squashfs -comp xz

# Mount
mount -t squashfs rootfs.squashfs /mnt -o loop
```

#### 10.2.7 EROFS (Enhanced Read-Only File System)

- **Read-only filesystem**
- **Better read performance** so với SquashFS
- Used in **Android phones**
- Fixed-output-file feature

```bash
mkfs.erofs rootfs.erofs source_dir
mount -t erofs -o loop rootfs.erofs /mnt
```

### 10.3 Benchmark Comparison

| Filesystem | Read Speed | Write Speed | Compression |
|------------|------------|-------------|------------|
| ext4 | Fast | Fast | None |
| XFS | Fast | Medium | None |
| Btrfs | Medium | Medium | Optional |
| F2FS | Fast | Fast | Optional |
| SquashFS | Good | N/A (read-only) | Best |
| EROFS | Very Fast | N/A (read-only) | Good |

### 10.4 Sử dụng Filesystem Images

#### Mount loop device

```bash
# Tạo empty image
dd if=/dev/zero of=rootfs.img bs=1M count=256

# Format
mkfs.ext4 rootfs.img

# Mount với loop
mount -t ext4 -o loop rootfs.img /mnt/test

# Partition trong image
losetup -fP --show rootfs.img
# → /dev/loop0
mkfs.ext4 /dev/loop0p1
mount /dev/loop0p1 /mnt
losetup -d /dev/loop0
```

#### Tạo read-only root với tmpfs cho /var

```
/ (SquashFS - ro) → tmpfs (/var) → block device (rw)
```

---

## 11. Phần 9: Flash Storage và MTD

### 11.1 MTD Subsystem

**MTD** (Memory Technology Devices) cho **NOR và NAND flash**.

#### MTD Partitioning

```bash
# Kernel command line
mtdparts=mtdparts=<device>:<size1>(name1),<size2>(name2)

# Ví dụ
mtdparts=spi0.0:1M(u-boot),64K(env),4M(kernel),-(rootfs)
```

#### MTD Device Nodes

```
/dev/mtd0        # Character device (full flash)
/dev/mtdblock0   # Block device (emulated)
```

#### MTD Utilities

```bash
# Erase NOR flash
flash_eraseall /dev/mtd0

# Write to NOR flash
nandwrite /dev/mtd1 uImage

# NAND operations
nandwrite, nanddump, nandtest
```

### 11.2 Flash Filesystems

#### 11.2.1 JFFS2 (Journaling Flash File System 2)

- **Legacy filesystem**
- Journaling cho reliability
- Tốt cho small partitions
- Tốn overhead cho lớn partitions

```bash
mkfs.jffs2 -d /source -o rootfs.jffs2 -e 0x20000 --pad=0x800000
```

#### 11.2.2 UBI/UBIFS

**UBI (Unsorted Block Images):**
- Logical volumes trên MTD
- Wear leveling across entire storage
- Bad block handling
- Atomic operations

**UBIFS:**
- Journaling filesystem trên UBI
- Better scalability than JFFS2
- Online checkpointing

```bash
# Tạo UBI image
mkfs.ubifs -d rootfs -o rootfs.ubifs -e 0x1F800 -c 4095 -m 0x800

# Tạo UBI volume
ubinize -o ubi.img -O 2048 ubinize.cfg

# ubinize.cfg
[ubifs]
mode=ubi
image=rootfs.ubifs
vol_id=0
vol_size=200MiB
vol_type=dynamic
vol_name=rootfs
vol_flags=autoresize
```

#### 11.2.3 Block Emulation Layers

| Layer | Mô tả |
|-------|-------|
| `mtdblock` | Block device trên MTD |
| `ubiblock` | Read-only block trên UBI |

---

## 12. Phần 10: Cross-compiling Libraries và Applications

### 12.1 Khái niệm Build System

**Build system** tự động hóa quá trình build từ source code.

**Types:**
- Hand-written Makefiles
- **Autotools** (autoconf, automake, libtool)
- **CMake**
- **Meson**
- SCons, Waf, ninja

### 12.2 Target vs. Staging

| Khái niệm | Mô tả |
|-----------|-------|
| **Build** | Quá trình biên dịch (host machine) |
| **Target** | Nơi ứng dụng chạy (embedded device) |
| **Staging** | sysroot để cài đặt target binaries |

### 12.3 Cross-compilation với Makefile đơn giản

```makefile
CC = arm-linux-gnueabihf-gcc
CFLAGS = -Wall -O2
SYSROOT = /path/to/sysroot

all: myapp

myapp: main.o utils.o
    $(CC) $(CFLAGS) -o $@ $^

%.o: %.c
    $(CC) $(CFLAGS) -I./include -c $< -o $@

install: myapp
    install -d $(DESTDIR)/usr/bin
    install -m 755 myapp $(DESTDIR)/usr/bin/

clean:
    rm -f *.o myapp
```

### 12.4 pkg-config

```bash
# Tìm library
pkg-config --cflags --libs libfoo

# Cross-compilation setup
export PKG_CONFIG_LIBDIR="/path/to/sysroot/usr/lib/pkgconfig"
export PKG_CONFIG_SYSROOT_DIR="/path/to/sysroot"

pkg-config --cflags --libs libmnl
```

### 12.5 Autotools (Autoconf/Automake)

**Workflow:**

```
1. autoreconf -i          # Tạo configure script
2. ./configure [options]   # Kiểm tra môi trường, tạo Makefiles
3. make                    # Build
4. make install            # Install
```

#### Ví dụ configure options

```bash
./configure \
    --host=arm-linux-gnueabihf \
    --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --enable-shared \
    --disable-static
```

### 12.6 CMake

**CMakeLists.txt:**

```cmake
cmake_minimum_required(VERSION 3.10)
project(myapp C)

set(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc)

add_executable(myapp main.c utils.c)
target_link_libraries(myapp m)

install(TARGETS myapp DESTINATION bin)
```

**Build:**

```bash
mkdir build && cd build
cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain.cmake ..
make
```

**Toolchain file:**

```cmake
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc)
set(CMAKE_FIND_ROOT_PATH /path/to/sysroot)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
```

### 12.7 Meson

**meson.build:**

```meson
project('myapp', 'c',
    default_options: ['warning_level=2']
)

# Tìm dependency
libmnl = dependency('libmnl')

# Tạo executable
executable('myapp',
    'main.c',
    'utils.c',
    dependencies: libmnl,
    install: true
)
```

**Cross-file cho cross-compilation (`cross.txt`):**

```ini
[binaries]
c = '/usr/bin/arm-linux-gnueabihf-gcc'
ar = '/usr/bin/arm-linux-gnueabihf-ar'
pkgconfig = '/usr/bin/arm-linux-gnueabihf-pkg-config'

[host_machine]
system = 'linux'
cpu_family = 'arm'
cpu = 'armv7'
endian = 'little'
```

**Build:**

```bash
meson setup build --cross-file cross.txt
cd build
ninja
ninja install
```

### 12.8 Ví dụ Cross-compiling Applications

#### can-utils (Linux CAN utilities)

```bash
git clone https://github.com/linux-can/can-utils.git
cd can-utils
make CC=arm-linux-gnueabihf-gcc
```

#### cJSON (JSON parser)

```bash
git clone https://github.com/DaveGamble/cJSON.git
cd cJSON
mkdir build && cd build
cmake -DCMAKE_TOOLCHAIN_FILE=../arm-toolchain.cmake ..
make
```

---

## 13. Phần 11: Embedded Build Systems

### 13.1 Ba cách tiếp cận

| Cách | Mô tả | Độ phức tạp |
|------|-------|-------------|
| **Manual** | Cross-compile mọi thứ bằng tay | Thấp, nhưng tốn thời gian |
| **Binary Distro** | Dùng Debian/Ubuntu/Fedora embedded | Trung bình |
| **Build Systems** | Yocto, Buildroot, OpenWrt | Cao, nhưng mạnh mẽ |

### 13.2 Binary Distributions

#### Debian
```bash
# Multiarch support
dpkg --add-architecture armhf
apt install gcc-arm-linux-gnueabihf
```

#### Raspberry Pi OS
- Officially supported ARMhf
- Có phiên bản Lite không có desktop

#### Alpine Linux
- **musl-based** (không phải glibc)
- Rất nhẹ
- Package manager: `apk`

#### Fedora
- Hỗ trợ nhiều embedded architectures
- ARM, AArch64, MIPS, PowerPC

### 13.3 Buildroot

#### Giới thiệu

- **Build system đơn giản** dựa trên Makefiles
- ~2800 packages
- Hỗ trợ uClibc, glibc, musl
- Không có package manager (static linked hoặc monolithic rootfs)

#### Configuration

```bash
make menuconfig
```

**Menu chính:**
- Target options
- Build options
- Toolchain
- System configuration
- Kernel
- Target packages
- Filesystem images
- Bootloaders

#### Build

```bash
make
```

**Output:**
```
output/
├── images/           # Final images
│   ├── rootfs.ext2
│   ├── zImage
│   └── u-boot.bin
├── build/            # Build directory
├── host/            # Host tools
└── staging/         # Sysroot
```

#### Thêm Package vào Buildroot

**Config (.mk file):**

```makefile
################################################################################
# myapp
################################################################################
MYAPP_VERSION = 1.0.0
MYAPP_SITE = /local/source
MYAPP_SITE_METHOD = local
MYAPP_INSTALL_TARGET = YES

define MYAPP_BUILD_CMDS
    $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(MYAPP_SITE)
endef

define MYAPP_INSTALL_TARGET_CMDS
    $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(MYAPP_SITE) install
endef

$(eval $(generic-package))
```

### 13.4 Yocto Project / OpenEmbedded

#### Giới thiệu

- **Layer-based** architecture
- Phức tạp nhưng rất mạnh mẽ
- Hỗ trợ **package management** (.deb, .rpm, .ipk)
- **Caching** build outputs

#### Core Layers

| Layer | Mô tả |
|-------|-------|
| `poky` | Reference distribution |
| `openembedded-core` | Base metadata |
| `meta-openembedded` | Additional packages |
| `meta-qt*` | Qt framework |
| `meta-*` | Vendor BSP layers |

#### Các thành phần

- **Recipes:** Instructions để build packages
- **Machines:** Board configurations
- **Distros:** Distribution configurations
- **BitBake:** Build orchestration tool

#### Ví dụ Recipe (libmnl)

```bitbake
DESCRIPTION = "Minimalistic Netlink library"
HOMEPAGE = "http://www.netfilter.org/projects/libmnl/"
LICENSE = "LGPL-2.1-or-later"
LIC_FILES_CHKSUM = "file://src/libmnl.c;beginline=1;endline=20;md5=..."

SRC_URI = "http://www.netfilter.org/projects/libmnl/files/${BPN}-${PV}.tar.bz2"
SRC_URI[md5sum] = "..."

inherit autotools

EXTRA_OECONF = "--enable-static"

BBCLASSEXTEND = "native nativesdk"
```

#### Build với bitbake

```bash
# Initialize build environment
source oe-init-build-env

# Build image
bitbake core-image-minimal

# Build SDK
bitbake -c populate_sdk core-image-minimal
```

### 13.5 Buildroot vs. Yocto

| Tiêu chí | Buildroot | Yocto |
|----------|-----------|-------|
| **Độ phức tạp** | Thấp | Cao |
| **Tốc độ build** | Nhanh | Chậm (có caching) |
| **Package management** | Không | Có (.deb, .rpm, .ipk) |
| **Customization** | Limited | Rất linh hoạt |
| **Learning curve** | Dễ hơn | Khó hơn |
| **Production-ready** | Có | Có |
| **Best for** | Simple devices | Complex products |

### 13.6 OpenWrt

- Chuyên biệt cho **WiFi routers** và **networking equipment**
- Sử dụng **target/device/package** system
- Custom build system (Makefiles-based)
- Website: https://openwrt.org

### 13.7 ELBE và Debos

- **ELBE:** Build Debian-based embedded images
- **Debos:** Debian-based OS builder

---

## 14. Phần 12: Open Source Licenses

### 14.1 Software Freedom vs. Open Source

| Khái niệm | Định nghĩa bởi |
|-----------|----------------|
| **Free Software** | FSF - 4 freedoms |
| **Open Source** | OSI - 10 criteria |

### 14.2 License Categories

#### 14.2.1 Non-copyleft (Permissive)

| License | Đặc điểm |
|---------|-----------|
| **BSD** | Cho phép proprietary use, attribution required |
| **MIT** | Tương tự BSD, simple và brief |
| **Apache 2.0** | Similar to BSD + patent grant |
| **X11 (MIT)** | Như MIT nhưng với X11 clause |

#### 14.2.2 Copyleft (VirAL)

| License | Đặc điểm |
|---------|-----------|
| **GPLv2** | Dùng trong Linux, U-Boot |
| **GPLv3** | Thêm patent grant, anti-tivoization |
| **LGPL** | Weak copyleft, cho libraries |
| **AGPL** | Network use also triggers obligations |

### 14.3 GPL Details

**Strong copyleft:**
- Programs **linked** against GPL library phải là GPL
- **Không có obligation** khi không phân phối software

**Source code availability:**
- Phải cung cấp source khi phân phối binary
- Có thể dùng "offer to provide source"

### 14.4 LGPL Details

**Weak copyleft:**
- Programs **linked** against LGPL library **không cần** là LGPL
- Chỉ cần dynamic linking
- Hoặc cung cấp object files để relink

### 14.5 GPL v2 vs v3

**GPLv3 thêm:**
1. **Explicit patent grant** - Grant license cho patents liên quan
2. **Anti-tivoization clause** - Không được cấm user thay đổi software
3. **30-day grace period** - Có 30 ngày để tuân thủ sau vi phạm

### 14.6 Best Practices

#### Compliance Checklist

1. **Identify all licenses** trong codebase
2. **Categorize licenses** (permissive vs. copyleft)
3. **Preserve attribution** và license notices
4. **Keep modifications separate** từ original code
5. **Use build system** để generate license lists

#### Generate License Info (Buildroot)

```bash
make legal-info
```

Output trong `output/legal-info/`.

### 14.7 License Compatibility Matrix

| Using | Linking to | Allowed? |
|-------|------------|----------|
| GPL | GPL | Yes |
| GPL | LGPL | Yes |
| GPL | Permissive | Yes |
| LGPL | LGPL | Yes |
| LGPL | Permissive | Yes |
| Permissive | GPL | Yes (but result is GPL) |
| Permissive | Permissive | Yes |
| Proprietary | Permissive | Yes |
| Proprietary | LGPL | Yes (dynamic only) |
| Proprietary | GPL | No (unless exception) |

---

## 15. Phần 13: Embedded Linux Software Stacks

### 15.1 D-Bus

**Message-oriented middleware** cho inter-process communication (IPC).

**Bus types:**
- **System bus:** System-wide services (logind, udisks)
- **Session bus:** Per-user session

```bash
# D-Bus tools
dbus-send          # Send message
dbus-monitor       # Monitor messages
```

### 15.2 systemd

**Modern init system** với nhiều tính năng:

**Features:**
- Parallel startup
- Service management
- Socket activation
- Timer-based activation
- Dependency-based ordering

**Components:**
- **systemd** - Init system
- **journald** - Logging
- **networkd** - Network management
- **udevd** - Device management
- **logind** - Session management

**Unit files (`/etc/systemd/system/`):**

```ini
[Unit]
Description=My Application
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/myapp
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

**Commands:**

```bash
systemctl start myapp
systemctl stop myapp
systemctl restart myapp
systemctl status myapp
systemctl enable myapp
systemctl disable myapp

journalctl -u myapp
journalctl -f
```

**Lưu ý:** systemd yêu cầu **glibc** (không hỗ trợ uClibc/musl).

### 15.3 Graphics Stack

#### 15.3.1 Display Drivers

| Technology | Mô tả |
|------------|-------|
| **fbdev** | Framebuffer device (deprecated) |
| **DRM/KMS** | Direct Rendering Manager / Kernel Mode Setting (modern) |

**DRM components:**
- **KMS** - Mode setting
- **GEM** - Graphics Execution Manager
- **PRIME** - Buffer sharing
- **Display planes/overlays**

#### 15.3.2 GPU Support

- **OpenGL** via Mesa3D (open-source)
- **Proprietary drivers:** NVIDIA, AMD, Intel (some embedded)

#### 15.3.3 Display Servers

| Server | Mô tả |
|--------|-------|
| **X11** | Traditional, widely used |
| **Wayland** | Modern replacement, modern display stack |
| ** Weston** | Reference Wayland compositor |
| **Mir** | Canonical's compositor |

#### 15.3.4 Wayland Compositors

| Compositor | Đặc điểm |
|------------|----------|
| **Weston** | Reference implementation |
| **Mutter** | GNOME's compositor |
| **KWin** | KDE's compositor |
| **wlroots** | Sway, Wayfire |

#### 15.3.5 GUI Toolkits

| Toolkit | License | Platforms |
|---------|---------|-----------|
| **Qt** | LGPL/GPL/Commercial | Embedded, Desktop, Mobile |
| **GTK** | LGPL | Linux, Mobile (GTK4/GNOME) |
| **Flutter** | BSD | Linux, Embedded |
| **SDL** | zlib | Games, Cross-platform |
| **EFL** | BSD | Embedded |
| **LVGL** | MIT | Embedded (lightweight) |

**Qt compilation:**

```bash
# Configure cho embedded Linux
./configure -platform linux-oe-g++ -device linux-imx6-g++

# Build
make
make install
```

### 15.4 Multimedia Stack

#### 15.4.1 Audio

| Layer | Component |
|-------|-----------|
| **Kernel** | ALSA (Advanced Linux Sound Architecture) |
| **User-space** | alsa-lib |
| **Servers** | JACK, PulseAudio, PipeWire |

**ALSA:**
- Kernel subsystem
- Device drivers
- Mixer control

**User-space:**
```bash
# List devices
aplay -l
arecord -l

# Test
aplay test.wav
arecord -d 5 test.wav
```

#### 15.4.2 Video Capture

| API | Mô tả |
|-----|-------|
| **V4L2** | Video4Linux2 - capture devices |
| **libv4l** | Library wrapper for V4L2 |
| **libcamera** | New camera API (2020+) |

```bash
# List video devices
v4l2-ctl --list-devices
```

#### 15.4.3 GStreamer

**Media pipeline framework:**

```bash
# Play video
gst-launch-1.0 playbin uri=file:///path/to/video.mp4

# Pipeline example
gst-launch-1.0 v4l2src ! video/x-raw ! xvimagesink

# Encode
gst-launch-1.0 v4l2src ! video/x-raw,width=640,height=480 ! \
    omxh264enc ! video/x-h264 ! filesink location=output.h264
```

### 15.5 Programming Languages

#### 15.5.1 Natively Compiled

| Language | Mô tả |
|----------|-------|
| **C** | System language, most supported |
| **C++** | Applications, Qt framework |
| **Rust** | Modern, memory-safe, growing support |
| **Go** | Systems language, easy cross-compilation |
| **Ada** | Safety-critical systems |
| **Fortran** | Scientific computing |

#### 15.5.2 Interpreted

| Language | Kích thước interpreter |
|----------|----------------------|
| **Python** | ~10-20 MB |
| **JavaScript/Node.js** | ~15-30 MB |
| **Lua** | Rất nhỏ (~150 KB) |
| **Shell/Bash** | Built-in |
| **Perl** | ~10 MB |
| **Ruby** | ~20 MB |
| **PHP** | ~5-10 MB |

### 15.6 Web UI Options

| Option | Mô tả |
|--------|--------|
| **Busybox httpd** | Lightweight, minimal |
| **lighttpd** | Lightweight web server |
| **nginx** | High-performance |
| **Apache** | Full-featured |
| **Cog** | Wayland-focused launcher |
| **Electron** | Web-based apps |

**Web engines:**
- **WebKitGTK** - Open-source
- **Blink** - Chrome's engine

---

## 16. Phần 14: Application Development

### 16.1 Development Workflow

1. **Host development** (cross-compilation)
2. **Deploy** to target (via NFS, SCP, USB, serial)
3. **Test and debug**
4. **Iterate**

### 16.2 Build Systems

#### CMake với Meson

**CMake toolchain file:**

```cmake
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc)
set(CMAKE_FIND_ROOT_PATH /path/to/sysroot)
```

#### Meson project example

```meson
project('myapp', 'c',
    version: '1.0.0',
    default_options: ['warning_level=2', 'optimization=2']
)

# Dependencies
libmnl = dependency('libmnl', required: true)
libnl = dependency('libnl-3.0')

# Executable
executable('myapp',
    'main.c',
    'config.c',
    dependencies: [libmnl, libnl],
    install: true
)

# Tests
test('basic_test', executable('test_basic', 'test_basic.c'))
```

**Build:**

```bash
meson setup builddir --cross-file cross.txt
cd builddir
ninja
```

### 16.3 Makefile Examples

#### Simple Makefile

```makefile
CC = arm-linux-gnueabihf-gcc
CFLAGS = -Wall -Wextra -O2 -I./include
LDFLAGS = -lm

TARGET = myapp
SRC = $(wildcard src/*.c)
OBJ = $(SRC:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJ)
    $(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.c
    $(CC) $(CFLAGS) -c $< -o $@

clean:
    rm -f $(OBJ) $(TARGET)

.PHONY: all clean
```

#### Makefile với Autotools-style

```makefile
DESTDIR ?=
PREFIX = /usr

bindir = $(DESTDIR)$(PREFIX)/bin
mandir = $(DESTDIR)$(PREFIX)/share/man

install: $(TARGET)
    install -d $(bindir) $(mandir)/man1
    install -m 755 $(TARGET) $(bindir)/
    install -m 644 $(TARGET).1 $(mandir)/man1/
```

---

## 17. Phần 15: Debugging

### 17.1 GDB (GNU Project Debugger)

**Remote debugging architecture:**

```
┌────────────────┐         ┌────────────────┐
│  Host (x86)    │  TCP/    │  Target (ARM)  │
│  ┌──────────┐  │  Serial │  ┌──────────┐  │
│  │  GDB     │──┼─────────┼──│ gdbserver │  │
│  └──────────┘  │         │  └──────────┘  │
└────────────────┘         └────────────────┘
```

**Setup on target:**

```bash
# Compile application với debug symbols
arm-linux-gnueabihf-gcc -g -o myapp myapp.c

# Copy to target và run gdbserver
gdbserver :2345 ./myapp
```

**Connect from host:**

```bash
arm-linux-gnueabihf-gdb myapp
(gdb) target remote <target-ip>:2345
(gdb) break main
(gdb) continue
```

### 17.2 GDB Commands

| Command | Short | Mô tả |
|---------|-------|-------|
| `break <location>` | `b` | Đặt breakpoint |
| `print <expr>` | `p` | In giá trị expression |
| `continue` | `c` | Tiếp tục execution |
| `next` | `n` | Step over function |
| `step` | `s` | Step into function |
| `backtrace` | `bt` | Show call stack |
| `info threads` | | Show threads |
| `thread <id>` | | Switch to thread |
| `list` | `l` | Show source code |
| `finish` | | Run until function returns |
| `delete <bp-id>` | | Delete breakpoint |
| `set variable` | | Set variable value |
| ` disassemble` | | Disassemble function |

### 17.3 Core Dumps

**Target setup:**

```bash
# Enable core dumps
ulimit -c unlimited

# Set core dump pattern
echo '/tmp/core.%e.%p' > /proc/sys/kernel/core_pattern
```

**Analyze on host:**

```bash
arm-linux-gnueabihf-gdb myapp /tmp/core.*
(gdb) bt
(gdb) info registers
(gdb) x/16x $sp
```

### 17.4 Memory Debugging

#### Valgrind

**Framework for instrumentation:**

```bash
valgrind --tool=memcheck ./myapp
valgrind --tool=helgrind ./myapp
valgrind --tool=callgrind ./myapp
valgrind --tool=massif ./myapp
```

**Tools:**

| Tool | Mô tả |
|------|-------|
| **memcheck** | Memory errors (leaks, uninitialized) |
| **cachegrind** | Cache simulation |
| **callgrind** | Call graph generation |
| **massif** | Heap profiler |
| **helgrind** | Thread errors |

**Lưu ý:** Valgrind chạy trên **synthetic CPU**, chậm hơn ~100x nhưng rất chi tiết.

---

## 18. Phần 16: Tracing và Profiling

### 18.1 strace (System Call Tracer)

**Cài đặt:**

```bash
# Cross-compile strace
git clone https://github.com/strace/strace.git
cd strace
./bootstrap
./configure --host=arm-linux-gnueabihf
make
```

**Sử dụng:**

```bash
# Trace system calls
strace ./myapp

# Trace child processes
strace -f ./myapp

# Trace running process
strace -p <pid>

# Summary count
strace -c ./myapp

# Filter by call type
strace -e trace=read,write,open,close ./myapp

# Timestamp
strace -t ./myapp
strace -tt ./myapp
```

**Output format:**

```
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
open("/lib/arm-linux-gnueabihf/libc.so.6", O_RDONLY|O_LARGEFILE) = 3
```

### 18.2 ltrace (Library Call Tracer)

```bash
# Trace library calls
ltrace ./myapp

# Kết hợp với system calls
ltrace -S ./myapp

# Summary
ltrace -c ./myapp
```

### 18.3 ftrace (Kernel Tracing)

**Traces:**
- Function calls
- Function graph
- Tracepoints
- Hardware events

**Access via tracefs:**

```bash
# Mount tracefs
mount -t tracefs nodev /sys/kernel/tracing

# Enable function tracing
echo function > /sys/kernel/tracing/current_tracer

# Read output
cat /sys/kernel/tracing/trace

# Disable
echo nop > /sys/kernel/tracing/current_tracer
```

**Kết hợp với events:**

```bash
# List available tracers
cat /sys/kernel/tracing/available_tracers

# Available events
ls /sys/kernel/tracing/events/

# Enable event
echo 1 > /sys/kernel/tracing/events/sched/sched_wakeup/enable

# Filter
echo 'comm==myapp' > /sys/kernel/tracing/events/sched/sched_wakeup/filter
```

**kernelshark:**

```bash
# Convert trace to viewable format
perf data convert --to-kernel-trace
kernelshark
```

### 18.4 perf (Performance Counters)

**Kernel configuration:**

```
CONFIG_PERF_EVENTS=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER=y
```

**Commands:**

```bash
# CPU performance counters
perf stat ./myapp

# Record with sampling
perf record -g ./myapp
perf report

# List available events
perf list

# Specific events
perf stat -e cycles,instructions,cache-misses ./myapp

# Hardware events
perf stat -e 'cpu-clock,task-clock,context-switches' ./myapp

# Tracepoints
perf record -e sched:sched_switch ./myapp

# kprobes
perf probe --add='kernel_function'
perf record -e probe:kernel_function ./myapp

# uprobes (user-space)
perf probe -x /bin/myapp my_function
perf record -e probe:my_function ./myapp
```

### 18.5 gprof (Application Profiler)

**Compile với profiling:**

```bash
gcc -pg -g -o myapp myapp.c
```

**Run và analyze:**

```bash
./myapp
gprof myapp gmon.out > analysis.txt
```

---

## 19. Tài nguyên và Kết luận

### 19.1 Sách

| Sách | Mô tả |
|------|-------|
| **Mastering Embedded Linux Programming, 4th Edition (2025)** | Comprehensive guide to embedded Linux |
| **The Linux Programming Interface** | Linux system programming bible |
| **Linux Device Drivers, 3rd Edition** | Classic driver development guide |

### 19.2 Websites

- **ELinux.org** - Embedded Linux Wiki
- **LWN.net** - Linux news, in-depth articles
- **Bootlin Blog** - Technical articles

### 19.3 Hội nghị

| Hội nghị | Địa điểm | Thời gian |
|----------|----------|-----------|
| **Embedded Linux Conference (ELC)** | North America, Europe | Spring |
| **Linux Plumbers Conference (LPC)** | Various | Fall |
| **FOSDEM** | Brussels, Belgium | February |
| **Embedded Recipes** | Nice, France | Fall |

### 19.4 Kết luận

> *"And may the Source be with you!"*

---

**Document License:** Creative Commons Attribution-ShareAlike 3.0  
**Source:** Bootlin - Embedded Linux System Development Training  
**Total slides:** 553  
**Last updated:** April 17, 2026  
**Website:** https://bootlin.com/training/embedded-linux
