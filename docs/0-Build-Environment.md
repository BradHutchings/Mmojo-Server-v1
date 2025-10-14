## 0. Build Environment

Brad Hutchings<br/>
brad@bradhutchings.com

Before you can build `mmojo-server`, `mmojo-server-one`, and other targets, you need to set up a build environment. I use two build environments regularly:
- Ubuntu 24.04 Server (Debian 13 Trixie) for x86_64 in a virtual machine.
- Raspberry Pi 5 (ARM64) running Raspberry Pi OS (Debian 13 Trixie).

If you want your platform native builds to support Debian 12 Bookworm, use Ubuntu 23.04 Server for x86_64 and Bookworm version of Raspberry Pi OS. The compatibility issue is that you need to link against the earliest glibc that you support. This only affects platform native builds. Cosmo builds statically link against the Cosmo glibc.

I plan to add into my regular mix and provide custom build instructions in the future:
- RHEL, CentOS Stream, Oracle Linux, etc. for x86_64 in a virtual machine.
- macOS on Mac Mini M4.

You only need to set up each build environment once. 

Skip ahead to: [1. Download](1-Download.md).

---
### Set Your System's Timezone
The Completion UI indicates a build date in its Settings panel. Set your build system's time zone so that the displayed build date is local to you.

List available time zone names:
```
timedatectl list-timezones | column
```

Set your system's time zone:
```
sudo timedatectl set-timezone America/Los_Angeles
```

Reference: [Timedatectl can control your Linux time and time zone](https://www.networkworld.com/article/970572/using-the-timedatectl-command-to-control-your-linux-time-and-time-zone.html).

---
### Debian (Ubuntu, Rasberry Pi OS) Build Dependencies
Here are some packages that should be adequate for creating a working build system. You may need to install more.
```
sudo apt install -y git python3-pip build-essential zlib1g-dev \
    libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev \
    liblzma-dev tk-dev python3-tk cmake zip npm
printf "\n**********\n*\n* FINISHED: Build Dependencies.\n*\n**********\n\n"
```

#### Debian: aarch64 (arm64) Support on x86_64
ARM has a few names for various versions and purposes of developer tools. `aarch64` means the same thing in some contexts as `arm64` does in others.

Do this if you're running on x86_64.
```
sudo dpkg --add-architecture arm64
sudo cat << EOF > ubuntu-arm64.sources
Types: deb
URIs: http://ports.ubuntu.com/ubuntu-ports/
Suites: noble noble-updates noble-security
Components: main restricted universe multiverse
Architectures: arm64
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
EOF
sudo mv ubuntu-arm64.sources /etc/apt/sources.list.d/ubuntu-arm64.sources
sudo apt update
sudo apt install -y libssl-dev:arm64
sudo apt install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu binutils-aarch64-linux-gnu
```

#### Debian: x86_64 Support on aarch64 (arm64)
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

The output should look like this:
```
/usr/lib/x86_64-linux-gnu/libssl.a
/usr/lib/aarch64-linux-gnu/libssl.a
/usr/lib/x86_64-linux-gnu/libcrypto.a
/usr/lib/aarch64-linux-gnu/libcrypto.a
```

I hope to be able to use these to replace the lengthy openssl build at some point. They aren't currently compatible with Cosmopolitan because `_FORTIFY_SOURCE` was used to build these static libraries.

---
### Next Step: Download 

Your build environment is ready to start building stuff. Let's download some files you will need next.

Next step: [1. Download](1-Download.md).
