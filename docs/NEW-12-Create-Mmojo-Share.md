## 12. Create Mmojo Share

Brad Hutchings<br/>
brad@bradhutchings.com

---
### Create Mmojo Share
The Mmojo Share is a file share where I keep files for local access and completed builds. It lets me build different items on different build platforms. I use a Ubuntu 24.04 virtual machine to build and test x86_64 and cosmo builds. I use a Raspberry Pi for building and testing ARM64 and Pi specific builds, including with Vulkan support. The Mmojo Share lets me keep .gguf models to test with locally and is where I copy completed and packaged builds. Your Mmojo Share will help you organize your builds as well.

1. Create an smb share on a computer on your network. It should have a user and password so you can access it from your build systems.
2. Create `/mnt/mmojo` directory.
3. Create `~/scripts` directory.
4. Create a `mount-mmojo-share.sh` script, edit with your details.
5. Add `~/scripts` to your .bashrc and source it.

---
### Proceed
**Up:** [10. Prepare Build Environment](NEW-10-Prepare-Build-Environment.md)
- **Previous:** [11. Set Timezone](NEW-11-Set-Timezone.md)
- **Next:** [13. Install Dependencies](NEW-13-Install-Dependencies.md)

