## 20. Gather Buid Pieces

Brad Hutchings<br/>
brad@bradhutchings.com

---
### Introduction
We need a few items ready to build an Actually Portable Executable (APE) with Cosmopolitan and for other build considerations. These only need to be prepared once in each of your build environments and rebuilt occasionally.

If you have already prepared your build environment, skip ahead to: 
- ~~[30. Build Mmojo Server](NEW-30-Build-Mmojo-Server.md)~~.
- [OLD DOCS - 5.Build Mmojo Server](5-Build-Mmojo-Server). 

---
### Preparing Your Build Environment
Here are the things you need to do:
- [21. Download gguf Files](NEW-21-Download-gguf-Files.md) - Download `.gguf` model files from Hugging Face or copy from your Mmojo share.
- [22. Build Cosmopolitan](NEW-22-Build-Cosmopolitan.md) - Patch Cosmopolitan and build it.
- [23. Build llamafile](NEW-23-Build-llamafile.md) - Build `llamafile` so we can use its `zipalign` tool.
- [24. Build OpenSSL](NEW-24-Build-OpenSSL.md) - Build OpenSSL static libraries with Cosmopolitan.
- [25. Build Vulkan](NEW-25-Build-Vulkan.md) - Build Vulkan for platform optimized builds.

**Get Started:** [21. Download gguf Files](NEW-21-Download-gguf-Files.md)
