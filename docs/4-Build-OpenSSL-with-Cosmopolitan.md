## 4. Build OpenSSL with Cosmopolitan

Brad Hutchings<br/>
brad@bradhutchings.com

The fourth step in building Mmojo Server is to clone the OpenSSL repo, fix problems that affect building with Cosmopolitan, and build it. You don't need to do this every time you build Mmojo Server.

We need to build our own `libssl.a` and `libcrypto.a` becuase:
1. Actual Portable Executable (APE) does not support dynamic loading of libraries.
2. The `libssl.a` and `libcrypto.a` we get by installing `libssl-dev` is built with `_FORTIFY_SOURCE` and will not link against Cosmo's `libc.a`.

This is how I understand the problem. My understanding might be incorrect, but it bears out in trying to find workarounds.

Skip ahead to: [5a. Prepare to Build Mmojo Server](5a-Prepare-to-Build-Mmojo-Server.md).

---
### Environment Variables

Let's define some environment variables:
```
DOWNLOAD_DIR="1-DOWNLOAD"
BUILD_COSMOPOLITAN_DIR="2-BUILD-cosmopolitan"
BUILD_LLAMAFILE_DIR="3-BUILD-llamafile"
BUILD_OPENSSSL_DIR="4-BUILD-openssl"
COSMO_DIR="$BUILD_COSMOPOLITAN_DIR/cosmocc"
EXTRA_FLAGS=""
if [ -z "$SAVE_PATH" ]; then
  export SAVE_PATH=$PATH
fi
if [ -z "$TODAY" ]; then
  TODAY=$(date +%Y-%m-%d)
fi
printf "\n**********\n*\n* FINISHED: Environment Variables.\n*\n**********\n\n"
```

_Note that if you copy each code block from the guide and paste it into your terminal, each block ends with a message so you won't lose your place in this guide._

**Optional:** Set `$EXTRA_FLAGS` for profiling.
```
EXTRA_FLAGS=" -pg "
```

---
### Create Build Directory
```
mkdir -p ~/$BUILD_OPENSSSL_DIR
cd ~/$BUILD_OPENSSSL_DIR
cp -r ~/$COSMO_DIR .
printf "\n**********\n*\n* FINISHED: Create Build Directory.\n*\n**********\n\n"
```

---
### Build openssl with Cosmo
We need cross-architectire `libssl` and `libcrypto` static libraries to support SSL in `mmojo-server`.
```
export PATH="$(pwd)/cosmocc/bin:$SAVE_PATH"
export CC="cosmocc -I$(pwd)/cosmocc/include -L$(pwd)/cosmocc/lib -O3 $EXTRA_FLAGS "
export CXX="cosmocc -I$(pwd)/cosmocc/include \
    -I$(pwd)/cosmocc/include/third_party/libcxx \
    -L$(pwd)/cosmocc/lib -L$(pwd)/openssl -O3 $EXTRA_FLAGS"
export AR="cosmoar"
cd ~/$BUILD_OPENSSSL_DIR
cp -r /usr/include/openssl/ ./cosmocc/include/
cp -r /usr/include/x86_64-linux-gnu/openssl/* ./cosmocc/include/openssl
cp -r /usr/include/aarch64-linux-gnu/openssl/* ./cosmocc/include/openssl
git clone https://github.com/openssl/openssl.git
cd ~/$BUILD_OPENSSSL_DIR/openssl
./Configure no-asm no-dso no-afalgeng no-shared no-pinshared no-apps
make
cd ~/$BUILD_OPENSSSL_DIR
export PATH=$SAVE_PATH
printf "\n**********\n*\n* FINISHED: Build openssl with Cosmo.\n*\n**********\n\n"
```

---
### Next Step: Prepare to Build Mmojo Server

You've cloned the OpenSSL repo, fixed a couple Cosmopolitan-related issues, and built it with Cosmopolitan. You don't need to do this every time you build Mmojo Server.

Next step: [5a. Prepare to Build Mmojo Server](5a-Prepare-to-Build-Mmojo-Server.md).
