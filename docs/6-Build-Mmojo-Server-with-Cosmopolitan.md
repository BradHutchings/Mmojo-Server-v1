## 6. Build Mmojo Server with Cosmopolitan

Brad Hutchings<br/>
brad@bradhutchings.com

The soxth step in building Mmojo Server is to build a Mmojo Server with Cosmopoltan. The resulting combined binary file will run on x86 and ARM CPUs, and Windows, Linux, and macOS operating systems.

---
### Environment Variables

Let's define some environment variables:
```
DOWNLOAD_DIR="1-DOWNLOAD"
BUILD_COSMOPOLITAN_DIR="2-BUILD-cosmopolitan"
BUILD_OPENSSSL_DIR="3-BUILD-openssl"
BUILD_MMOJO_SERVER_DIR="4-BUILD-mmojo-server"
COSMO_DIR="$BUILD_COSMOPOLITAN_DIR/cosmocc"
if [ -z "$SAVE_PATH" ]; then
  export SAVE_PATH=$PATH
fi
TODAY=$(date +%Y-%m-%d)
printf "\n**********\n*\n* FINISHED: Environment Variables.\n*\n**********\n\n"
```

_Note that if you copy each code block from the guide and paste it into your terminal, each block ends with a message so you won't lose your place in this guide._

---
### Build Mmojo Server for x86_64.
We now use CMake to build Mmojo Server.
```
cd ~/$BUILD_MMOJO_SERVER_DIR
export PATH="$(pwd)/cosmocc/bin:$SAVE_PATH"
export CC="x86_64-unknown-cosmo-cc -I$(pwd)/cosmocc/include -L$(pwd)/cosmocc/lib -DCOSMOCC=1 -nostdinc"
export CXX="x86_64-unknown-cosmo-c++ -I$(pwd)/cosmocc/include  -DCOSMOCC=1 -nostdinc -nostdinc++ \
    -I$(pwd)/cosmocc/include/third_party/libcxx \
    -L$(pwd)/cosmocc/lib -L$(pwd)/openssl"
export AR="cosmoar"
# export UNAME_S="cosmocc"
# export UNAME_P="cosmocc-intel"
# export UNAME_M="cosmocc"
cmake -B build-cosmo-amd64 -DBUILD_SHARED_LIBS=OFF -DLLAMA_CURL=OFF \
    -DCMAKE_SYSTEM_NAME=Linux -DCMAKE_SYSTEM_PROCESSOR=x86_64
cmake --build build-cosmo-amd64 --config Release

printf "\n**********\n*\n* FINISHED: Build Mmojo Server for x86_64.\n*\n**********\n\n"
```

---
### Build Mmojo Server for ARM.
We now use CMake to build Mmojo Server.
```
cd ~/$BUILD_MMOJO_SERVER_DIR
export PATH="$(pwd)/cosmocc/bin:$SAVE_PATH"
export CC="aarch64-unknown-cosmo-cc -I$(pwd)/cosmocc/include -L$(pwd)/cosmocc/lib -DCOSMOCC=1 -nostdinc"
export CXX="aarch64-unknown-cosmo-c++ -I$(pwd)/cosmocc/include -DCOSMOCC=1 -nostdinc -nostdinc++ \
    -I$(pwd)/cosmocc/include/third_party/libcxx \
    -L$(pwd)/cosmocc/lib -L$(pwd)/openssl"
export AR="cosmoar"
# export UNAME_S="cosmocc"
# export UNAME_P="cosmocc-intel"
# export UNAME_M="cosmocc"
cmake -B build-cosmo-aarch64 -DBUILD_SHARED_LIBS=OFF -DLLAMA_CURL=OFF \
    -DCMAKE_SYSTEM_NAME=Linux -DCMAKE_SYSTEM_PROCESSOR=aarch64
cmake --build build-cosmo-aarch64 --config Release

printf "\n**********\n*\n* FINISHED: Build Mmojo Server for x86_64.\n*\n**********\n\n"
```

