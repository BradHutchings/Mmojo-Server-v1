## 13. Install Dependencies

Brad Hutchings<br/>
brad@bradhutchings.com

**The new documentation is under construction. Don't bookmark it or any pages in it yet. Links will change.**

---
### About this Step
Install system package updates, then install packages we will need for our build system.

---
### Install Package Updates
First, let's install any package updates.
```
sudo apt update
sudo apt upgrade -y

printf "\n**********\n*\n* FINISHED: Install Package Updates.\n*\n**********\n\n"
```

---
### Install Dependencies
Here are some packages that should be adequate for creating a working build system. You may need to install more.
```
sudo apt install -y \
    bison build-essential clang-format cmake g++ \
    gcc git libbz2-dev libffi-dev libglm-dev \
    liblz4-dev liblzma-dev libpciaccess0 libpng-dev libreadline-dev \
    libsqlite3-dev libssl-dev libwayland-dev libx11-dev libx11-xcb-dev \
    libxcb-cursor-dev libxcb-dri3-0 libxcb-dri3-dev libxcb-ewmh-dev libxcb-keysyms1-dev \
    libxcb-present0 libxcb-randr0-dev libxcb-xinerama0 libxcb-xinput0 libxml2-dev \
    libxrandr-dev libzstd-dev ninja-build npm ocaml-core \
    pkg-config python3 python3-pip python3-tk qt5-qmake \
    qtbase5-dev qtbase5-dev-tools qtcreator tk-dev wayland-protocols \
    xz-utils zip zlib1g-dev 

printf "\n**********\n*\n* FINISHED: Build Dependencies.\n*\n**********\n\n"
```

---
### Proceed
**Up:** [10. Prepare Build Environment](NEW-10-Prepare-Build-Environment.md)
- **Previous:** [12. Create Mmojo Share](NEW-12-Create-Mmojo-Share.md)
- **Next:** [14. Set up Cross Compile - aarch64 on x86_64](NEW-14-Set-up-Cross-Compile-aarch64-on-x86_64.md)


