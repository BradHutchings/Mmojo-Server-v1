## 5c. Build Mmojo Server with Cosmopolitan

Brad Hutchings<br/>
brad@bradhutchings.com

The fourth step in building Mmojo Server is to build the Mmojo Server.

In this third substep, we will build a Mmojo Server with Cosmopoltan. The resulting combined binary file will run on x86 and ARM CPUs, and Windows, Linux, and macOS operating systems.

---
### Environment Variables

Let's define some environment variables:
```
DOWNLOAD_DIR="1-DOWNLOAD"
BUILD_COSMOPOLITAN_DIR="2-BUILD-cosmopolitan"
BUILD_LLAMAFILE_DIR="3-BUILD-llamafile"
BUILD_OPENSSSL_DIR="4-BUILD-openssl"
BUILD_MMOJO_SERVER_DIR="5-BUILD-mmojo"
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
EXTRA_FLAGS=" -g -pg "
```

---
### Build Mmojo Server for x86_64.
We now use CMake to build Mmojo Server.
```
cd ~/$BUILD_MMOJO_SERVER_DIR
export PATH="$(pwd)/cosmocc/bin:$SAVE_PATH"
export CC="x86_64-unknown-cosmo-cc -I$(pwd)/cosmocc/include -L$(pwd)/cosmocc/lib -DCOSMOCC=1 -nostdinc -O3 $EXTRA_FLAGS "
export CXX="x86_64-unknown-cosmo-c++ -I$(pwd)/cosmocc/include  -DCOSMOCC=1 -nostdinc -nostdinc++ -O3 $EXTRA_FLAGS \
    -I$(pwd)/cosmocc/include/third_party/libcxx \
    -I$(pwd)/openssl/include \
    -L$(pwd)/cosmocc/lib -L$(pwd)/openssl"
export AR="cosmoar"
cmake -B build-cosmo-amd64 -DBUILD_SHARED_LIBS=OFF -DLLAMA_CURL=OFF -DLLAMA_OPENSSL=ON \
    -DCMAKE_SYSTEM_NAME=Linux -DCMAKE_SYSTEM_PROCESSOR=x86_64
cmake --build build-cosmo-amd64 --config Release
export PATH=$SAVE_PATH

printf "\n**********\n*\n* FINISHED: Build Mmojo Server for x86_64.\n*\n**********\n\n"
```

**Optional:** Test the build if you're building on an x86 system. If you've previously downloaded a model to the `1-DOWNLOAD` folder, you can test the build.
```
./build-cosmo-amd64/bin/mmojo-server --model ~/$DOWNLOAD_DIR/Google-Gemma-1B-Instruct-v3-q8_0.gguf \
    --path completion-ui/ --default-ui-endpoint "chat" --host 0.0.0.0 --port 8080 --batch-size 64 --ctx-size 0 --mlock
```

**Optional:** If you're profiling, get some profile output.
```
gprof build-cosmo-amd64/bin/mmojo-server gmon.out > build-cosmo-amd64/profile.txt
more build-cosmo-amd64/profile.txt
```

---
### Build Mmojo Server for ARM.
We now use CMake to build Mmojo Server.
```
cd ~/$BUILD_MMOJO_SERVER_DIR
export PATH="$(pwd)/cosmocc/bin:$SAVE_PATH"
export CC="aarch64-unknown-cosmo-cc -I$(pwd)/cosmocc/include -L$(pwd)/cosmocc/lib -DCOSMOCC=1 -nostdinc -O3 $EXTRA_FLAGS "
export CXX="aarch64-unknown-cosmo-c++ -I$(pwd)/cosmocc/include -DCOSMOCC=1 -nostdinc -nostdinc++ -O3 $EXTRA_FLAGS \
    -I$(pwd)/cosmocc/include/third_party/libcxx \
    -I$(pwd)/openssl/include \
    -L$(pwd)/cosmocc/lib -L$(pwd)/openssl/.aarch64/"
export AR="cosmoar"
cmake -B build-cosmo-aarch64 -DBUILD_SHARED_LIBS=OFF -DLLAMA_CURL=OFF -DLLAMA_OPENSSL=ON \
    -DCMAKE_SYSTEM_NAME=Linux -DCMAKE_SYSTEM_PROCESSOR=aarch64
cmake --build build-cosmo-aarch64 --config Release
export PATH=$SAVE_PATH

printf "\n**********\n*\n* FINISHED: Build Mmojo Server for ARM.\n*\n**********\n\n"
```

**Optional:** Test the build if you're building on an ARM system. If you've previously downloaded a model to the `1-DOWNLOAD` folder, you can test the build.
```
./build-cosmo-aarch64/bin/mmojo-server --model ~/$DOWNLOAD_DIR/Google-Gemma-1B-Instruct-v3-q8_0.gguf \
    --path completion-ui/ --default-ui-endpoint "chat" --host 0.0.0.0 --port 8080 --batch-size 64 --ctx-size 0 --mlock
```

**Optional:** If you're profiling, get some profile output.
```
gprof build-cosmo-aarch64/bin/mmojo-server gmon.out > build-cosmo-aarch64/profile.txt
more build-cosmo-aarch64/profile.txt
```

---
### Build mmojo-server Actual Portable Executable (APE)
Now that we have amd64 (x86) and aarch64 (ARM) builds, we can combine them into an Actual Portable Executable (APE) file.

```
cd ~/$BUILD_MMOJO_SERVER_DIR
export PATH="$(pwd)/cosmocc/bin:$SAVE_PATH"
apelink \
	-l ~/$BUILD_COSMOPOLITAN_DIR/o/x86_64/ape/ape.elf \
	-l ~/$BUILD_COSMOPOLITAN_DIR/o/aarch64/ape/ape.elf \
	-o mmojo-server build-cosmo-amd64/bin/mmojo-server build-cosmo-aarch64/bin/mmojo-server
export PATH=$SAVE_PATH
printf "\n**********\n*\n* FINISHED: Build mmojo-server Actual Portable Executable (APE).\n*\n**********\n\n"
```

Let's test our combined build:
```
./mmojo-server --model ~/$DOWNLOAD_DIR/Google-Gemma-1B-Instruct-v3-q8_0.gguf \
    --path completion-ui/ --default-ui-endpoint "chat" --host 0.0.0.0 --port 8080 --batch-size 64 --ctx-size 0 --mlock
```

---
### Next Step: Configure Mmojo Server

You've built the Mmojo Server. The `mmojo-server` binary with run on x86_64 and ARM CPUs, across Windows, Linux, and macOS.

Next step: [5. Configure Mmojo Server](5-Configure-Mmojo-Server.md).
