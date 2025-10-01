## 0. Linux Build Prerequisites

Brad Hutchings<br/>
brad@bradhutchings.com

Before you can build `mmojo-server` and `mmojo-server-one`, you need to set up your build environment. These instructions are tested on Ubuntu x86_64 Linux and Raspberry Pi (ARM).

You only need to set up your environment once. 

Skip ahead to: [1. Dwonload](1-Download.md).

---
### System Requirements
I build in a virtual machine running Ubuntu Server 24.04 x86_64. I also routinely test building on a Raspberry Pi 5 running the latest Raspberry Pi OS (64-bit), which is a Ubuntu derivative with a desktop and Pi things.

#### Disk Space
If you want to use my scripts to build a `mmojo-server-one` for each of the models available in my HuggingFace repo, you'll need about 120 GB (3 * 40 GB) of available space for the models and copies during the process. I would suggest having 300 GB available on your root `/`.

If you don't plan to build the fleet of `mmojo-server-one` Actual Portable Executable (APE) files with models embedded within them, 100 GB of disk space should be more than enough.

Check your disk space:
```
df -h
```

---
### Build Dependencies
Here are some packages that should be adequate for creating a working build system. You may need to install more.
```
sudo apt install -y git python3-pip build-essential zlib1g-dev \
    libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev \
    liblzma-dev tk-dev python3-tk cmake zip npm
printf "\n**********\n*\n* FINISHED: Build Dependencies.\n*\n**********\n\n"
```

---
### Support the Other Architecture (x86_64 or aarch64)
Cosmopolitan takes care of most cross-architecture things, but we will eventually want optimized `libssl.a` and `libcrypto.a` libraries not built locally from source.

#### Install aarch64 libssl-dev on x86_64
ARM has a few names for various versions and purposes of developer tools. `aarch64` means the same thing in some contexts as `arm64` does in others.

Do this if you're running on x86_64.
```
sudo cat << EOF > /etc/apt/sources.list.d/ubuntu-arm64.sources
Types: deb
URIs: http://ports.ubuntu.com/ubuntu-ports/
Suites: noble noble-updates noble-security
Components: main restricted universe multiverse
Architectures: arm64
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
EOF
sudo apt update
sudo apt install -y libssl-dev:arm64
```

#### Install x86_64 libssl-dev on ARM
Do this if you're running on aarch64/arm64:
```
# Coming soon
```

#### Verify that libssl.a and libcrypto.a are Installed for Both Architectures
Find where the files are under `/usr/lib`:
```
find /usr/lib -name "libssl.a"
find /usr/lib -name "libcrypto.a"
```
