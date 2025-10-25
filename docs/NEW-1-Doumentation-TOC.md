## 1. Documentation - Table of Contents

Brad Hutchings<br/>
brad@bradhutchings.com

**The new documentation is under construction. Don't bookmark it or any pages in it yet. Links will change.**

---
### Introduction
Welcome to the **Mmojo Server Documentation**. This page is a jump-off point for the things you need to do.

---
### Table of Contents
#### [10. Prepare Build Environment](NEW-10-Prepare-Build-Environment.md)
Before you can build Mmojo Server, you need a build environment. Depending on what you want to build, it could be a single computer or multiple computers. You should have a separate share on your network to keep files you only need to download once, and keep the products of your builds. You may find yourself rebuilding your build environments regularly, especially if you edit or enhance code and instructions in the repo.

- [11. Set Timezone](NEW-11-Set-Timezone.md) - Set your build system's time zone so Completion UI reflects correct build date.
- [12. Create Mmojo Share](NEW-12-Create-Mmojo-Share.md) - Create and mount a file share to support multiple build environments.
- [13. Install Dependencies](NEW-13-Install-Dependencies.md) - Install packages needed for your build system.
- [14. Set up Cross Compile - aarch64 on x86_64](NEW-14-Set-up-Cross-Compile-aarch64-on-x86_64.md) - Cross compiling architecture-specific Linux builds might work well in the future.
- [15. Set up Cross Compile - x86_64 on aarch64](NEW-15-Set-up-Cross-Compile-x86_64-on-aarch64.md) - Cross compiling architecture-specific Linux builds might work well in the future.

#### [20. Gather Build Pieces](NEW-20-Gather-Build-Pieces.md)
Prepare things needed to build Mmojo Server executables. 

- [21. Download gguf Files](NEW-21-Download-gguf-Files.md) - Download `.gguf` model files from Hugging Face or copy from your Mmojo share.
- [22. Build Cosmopolitan](NEW-22-Build-Cosmopolitan.md) - Patch Cosmopolitan and build it.
- [23. Build llamafile](NEW-23-Build-llamafile.md) - Build `llamafile` so we can use its `zipalign` tool.
- [24. Build OpenSSL](NEW-24-Build-OpenSSL.md) - Build OpenSSL static libraries with Cosmopolitan.
- [25. Build Vulkan](NEW-25-Build-Vulkan.md) - Build Vulkan for platform optimized builds.

#### [30. Build Mmojo Server](NEW-30-Build-Mmojo-Server.md)
Build Mmojo Server executables.

- [32. Build Test](NEW-32-Test.md) - Build an unoptimized `mmojo-server` for the build environment platformm that can be used to test features and changes.
- [33. Build APE](NEW-32-Build-APE.md) - Build `mmojo-server-ape` as an Actually Portable Executable (APE) with Cosmopolitan.
- [33. Build linux x86_64](NEW-33-Build-linux-x86_64.md) - Build unoptimized linux build for x86_64.
- [34. Build linux aarch64](NEW-34-Build-linux-aarch64.md) - Build unoptimized linux build for aarch64 (arm64).
- [35. Build pi5](NEW-35-Build-pi5.md) - Build optimized linux build for Raspberry Pi 3, 4, and 5.

[40. Package Mmojo Server](NEW-40-Package-Mmojo-Server.md) - **Not stubbed yet.**

