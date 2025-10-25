## 25. Build Vulkan

Brad Hutchings<br/>
brad@bradhutchings.com

**The new documentation is under construction. Don't bookmark it or any pages in it yet. Links will change.**

### About this Step
Vulkan is a newer industry standard API to help applications work seamlessly with GPUs from different vendors. GPU vendors provide Vulkan interfaces for their GPUs, which are loaded dynamically by applications which use the Vulkan API. It should be the easiest way to add GPU support to your builds for any particular device you have. However:

- Metal support on Mac M* chips is provided through a third-party open source project.
- Many systems with small GPUs do not support a large enough `maxComputeSharedMemorySize` in Vulkan for llama.cpp to work with it. Such systems include Raspberry Pi 5 and Intel Iris Xe built-in graphics.
- Since Vulkan interfaces with a dynamic library, we can't link to it with cross-platform and cross-architecture Cosmo builds.

Perform this step in both your x86_64 and your aarch64 (arm64) build environments.

---
### Build Vulkan

Instructions coming soon.

---
### Proceed
- **Next:** This is the last article in this section.
- **Previous:** [24. Build OpenSSL](NEW-24-Build-OpenSSL.md)
- **Up:** [20. Gather Build Pieces](NEW-20-Gather-Build-Pieces.md)

---
### Next Section
- **Next Section:** [30. Build Mmojo Server](NEW-30-Build-Mmojo-Server.md)

Jump instead to the old documentation: [5. Build Mmojo Server](5-Build-Mmojo-Server.md).
