## 14. Set up Cross Compile aarch64 on x86_64

Brad Hutchings<br/>
brad@bradhutchings.com

Cross-compiling llama.cpp does not work very well right now. The llama.cpp CMake build system is meant to discover the capabilities of the host machine and build for that. In particular, I run into problems with OpenSSL that need to be patched for cosmocc builds to link in compatible static libraries.

I've had some limited success building for Raspberry Pi (arm64) from x86_64 Ubuntu, but not for optimized builds. For example, a private summary benchmark I have, running on a Pi 5, takes about 45 minutes with the cosmocc build, 18 minutes with a cross-compiled build, and 7 minutes with an optimized build built on the Pi 5. I'm working towards getting optimized cross-compiled builds, but it's a long term goal.

---
### Set up Cross Compile aarch64 (arm64) on x86_64
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

---
### Proceed
**Up:** [10. Prepare Build Environment](NEW-10-Prepare-Build-Environment.md)
- **Previous:** [13. Install Dependencies](NEW-13-Install-Dependencies.md)
- **Next:** [15. Set up Cross Compile - x86_64 on aarch64](NEW-15-Set-up-Cross-Compile-x86_64-on-aarch64.md)
