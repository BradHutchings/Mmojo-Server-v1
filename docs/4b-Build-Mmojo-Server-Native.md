## 5. Build Mmojo Server - Native

Brad Hutchings<br/>
brad@bradhutchings.com

The fourth step in building Mmojo Server is to build the Mmojo Server.

In this second substep, we will build a native Mmojo Server for the build platform. You don't need to do this. It's a good check to make sure the mmojo-server code is in order. 

Skip ahead to: [4c. Build Mmojo Server with Cosmopolitan](4c-Build-Mmojo-Server-with-Cosmopolitan.md).

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
### Build Mmojo Server for build platform.
We now use CMake to build Mmojo Server.
```
cd ~/$BUILD_MMOJO_SERVER_DIR
export PATH=$SAVE_PATH
unset CC; export CC
unset CXX; export CXX
unset AR; export AR
cmake -B build-platform -DBUILD_SHARED_LIBS=OFF -DLLAMA_CURL=OFF
cmake --build build-platform --config Release

printf "\n**********\n*\n* FINISHED: Build Mmojo Server for build platform.\n*\n**********\n\n"
```

**Optional:** Test the build. If you've previously downloaded a model to the `1-DOWNLOAD` folder, you can test the build.
```
./build-platform/bin/mmojo-server --model ~/$DOWNLOAD_DIR/Google-Gemma-1B-Instruct-v3-q8_0.gguf \
    --path completion-ui/ --host 0.0.0.0 --port 8080
```

---
### Next Step: Build Mmojo Server with Cosmopolitan

You've cloned the OpenSSL repo, fixed a couple Cosmopolitan-related issues, and built it with Cosmopolitan. You don't need to do this every time you build Mmojo Server.

Next step: [4c. Build Mmojo Server with Cosmopolitan](4c-Build-Mmojo-Server-with-Cosmopolitan.md).
