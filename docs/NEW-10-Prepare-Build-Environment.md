## 10. Prepare Build Environment

Brad Hutchings<br/>
brad@bradhutchings.com

**The new documentation is under construction. Don't bookmark it or any pages in it yet. Links will change.**

---
### About this Section
Before you can build `mmojo-server`, `mmojo-server-one`, and other targets, you need to set up a build environment. I use two build environments regularly:
- Ubuntu 24.04 Server (Debian 13 Trixie) for x86_64 in a virtual machine.
- Raspberry Pi 5 (ARM64) running Raspberry Pi OS (Debian 13 Trixie).

If you want your platform native builds to support Debian 12 Bookworm, use Ubuntu 23.04 Server for x86_64 and Bookworm version of Raspberry Pi OS. The compatibility issue is that you need to link against the earliest glibc that you support. This only affects platform native builds. Cosmo builds statically link against the Cosmo glibc.

I plan to add into my regular mix and provide custom build instructions in the future:
- RHEL, CentOS Stream, Oracle Linux, etc. for x86_64 in a virtual machine.
- macOS on Mac Mini M4.

You only need to prepare each build environment once. 

If you have already prepared your build environment, skip ahead to: 
- [20. Gather Build Pieces](NEW-20-Gather-Build-Pieces.md).

---
### Preparing Your Build Environment
Here are the things you need to do:
- [11. Set Timezone](NEW-11-Set-Timezone.md)
- [12. Create Mmojo Shre](NEW-12-Create-Mmojo-Share.md)
- [13. Install Dependencies](NEW-13-Install-Dependencies.md)
- [14. Set up Cross Compile - aarch64 on x86_64](NEW-14-Set-up-Cross-Compile-aarch64-on-x86_64.md)
- [15. Set up Cross Compile - x86_64 on aarch64](NEW-15-Set-up-Cross-Compile-x86_64-on-aarch64.md)

**Get Started:** [11. Set Timezone](NEW-11-Set-Timezone.md)
