## 13. Set up Cross Compile aarch64 on x86_64

Brad Hutchings<br/>
brad@bradhutchings.com

This is a placeholder for new documentation, coming soon. It will be better organized, and more focused on specific tasks.

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
- **Previous:** [12. Install Dependencies](NEW-12-Install-Dependencies.md)
- **Next:** [14. Set up Cross Compile - x86_64 on aarch64](NEW-14-Set-up-Cross-Compile-x86_64-on-aarch64.md)
