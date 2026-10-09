# Building basics

This document will tell you how to build binaries with patches from spacerangershd-fpc-fixes repo.

It assumes that you are somewhat of a power user, so we won't be covering the basics here.

# Supported host operating systems

This project can be built both on Linux and Windows. 

Upstream also supports macOS host builds, but this project specifically does not support them yet.

Linux distros tested:

- Ubuntu 24.04.1
- Linux Mint Xia 22.1 (basically, an Ubuntu 24.04)
- Debian 13 Trixie

Windows versions tested:

- Windows 7 SP1
- Windows 10 (22H2)
- Windows 11 (25H2)

**A note on Windows 7 host support:** it is spotty.

You will require third-party homebrew versions of Python 3.1x and Git-for-Windows installed, since current versions of both of them require Windows 10 as a minimum. Plus to that, WinLibs toolkit that is used here to provide building environment is partially UCRT-linked, so you will also have to install UCRT patches to make it work properly.

**TL;DR: just update to 10/11 or switch to Linux, it's 2026 for fuck's sake.** But if you want to suffer, see [BUILD_WIN7](BUILD_WIN7.md).

At the moment, builds were tested only on x86_64 hosts. I have no ARM-powered PCs at my disposal right now, and I do not plan to support 32-bit platforms either.

# Linux dependencies

Ubuntu 24.04 & Linux Mint Xia: 

```
sudo apt update && sudo apt install -y build-essential git python3 cmake make pkg-config fpc fp-compiler libsdl2-dev libogg-dev libvorbis-dev libjpeg-turbo8-dev libpng-dev zlib1g-dev libxvidcore-dev libxvidcore4 gcc-mingw-w64-x86-64 g++-mingw-w64-x86-64 binutils-mingw-w64-x86-64 mingw-w64-tools unzip wget ca-certificates clang lld
```

Debian Trixie:

```
sudo apt update && sudo apt install -y build-essential git python3 cmake make pkg-config fpc libsdl2-dev libogg-dev libvorbis-dev libjpeg-dev libpng-dev zlib1g-dev libxvidcore-dev gcc-mingw-w64-x86-64 g++-mingw-w64-x86-64 binutils-mingw-w64-x86-64 mingw-w64-tools unzip wget ca-certificates clang lld
```

# Windows dependencies

- Python3 (https://www.python.org/downloads/windows)
- Git (https://git-scm.com/install/windows)

Make sure that you add both Python and Git to the PATH during their installation processes (tick required boxes).

Windows 7 users are required to read [BUILD_WIN7](BUILD_WIN7.md) in order to supply additional deps.

# Build on Linux

**NB: on Linux, you can build both Linux and Windows targets.**

1) Clone upstream:

```
git clone https://github.com/pakompom/SpaceRangersHD_FPC.git
cd SpaceRangersHD_FPC
git checkout --detach 5f491a841cbd11d2a9a6861a822a08ffa64d15f2
git submodule update --init --recursive
git -C vendor/fpc checkout --detach 3a1c9cfae7f7a2bb17079b2989f562dbc5728b01
git -C vendor/okgf checkout --detach c01aa7a168a6f1772541501074b7bba1b96550ef
cd ..
```
2) Clone this repo:

```
git clone https://github.com/giantplaceholder/spacerangershd-fpc-fixes.git
cp spacerangershd-fpc-fixes/*.patch SpaceRangersHD_FPC/
```

3) Apply the patches:

```
cd SpaceRangersHD_FPC
for p in {01..15}-*.patch; do git apply "$p" || break; done
```

4) Build binaries:

- For Linux, vendored fpc: `./tools/build.py --target linux --release`
- For Linux, system fpc: `./tools/build.py --target linux --release --system-fpc`
- For Windows: `./tools/build.py --target windows --release`

5) Freshly built binaries will be available at:

- Linux: `SpaceRangersHD_FPC/.local/linux-x86_64/release/bin`
- Windows: `SpaceRangersHD_FPC/.local/windows-x86_64/release/bin`

# Build on Windows

**NB: at the moment, you can only build a Windows target on Windows host.**

1) Clone this repo:

```
git clone https://github.com/giantplaceholder/spacerangershd-fpc-fixes.git
```

2) Prep the tree:

- Run `build-windows-00-prepare-tree.bat` and wait for it to finish

3) Launch the build:

- Run `build-windows-01-build.bat` and wait for it to finish

4) Freshly built binaries will be available at `SpaceRangersHD_FPC\.local\windows-x86_64\release\bin`
