## 3. Build Native Mmojo Server

Brad Hutchings<br/>
brad@bradhutchings.com

The third step in building Mmojo Server is to clone the mmojo-server repo, fix problems that affect building with Cosmopolitan, add some features for Mmojo Server, and build a native Mmojo Server for the build platform. You don't need to do this. It's a good check to make sure the mmojo-server code is in order. 

Skip ahead to: [5. Build Mmojo Server with Cosmopolitan](5-Build-Mmojo-Server-with-Cosmopolitan.md).

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
### Clone this Repo Locally
Clone this repo and repos this repo depends on into a `~\2-BUILD-mmojo-server` directory.
```
cd ~
git clone https://github.com/BradHutchings/mmojo-server.git ~/$BUILD_MMOJO_SERVER_DIR
cd ~/$BUILD_MMOJO_SERVER_DIR
git clone https://github.com/nlohmann/json.git nlohmann-json
git clone https://github.com/google/minja.git google-minja
git clone https://github.com/yhirose/cpp-httplib.git cpp-httplib
git clone https://github.com/mackron/miniaudio.git miniaudio
git clone https://github.com/nothings/stb.git stb
cp -r ~/$BUILD_COSMOPOLITAN_DIR/cosmocc .
cp -r ~/$BUILD_OPENSSSL_DIR/openssl .
printf "\n**********\n*\n* FINISHED: Clone this Repo and Dependent Repos Locally.\n*\n**********\n\n"
```

**Optional:** Use the `work-in-progress` branch where I implement and test my own changes and where I test upstream changes from `llama.cpp`.
```
cd ~/$BUILD_MMOJO_SERVER_DIR
git checkout work-in-progress
printf "\n**********\n*\n* FINISHED: Checkout work-in-progress.\n*\n**********\n\n"
```

#### Fix llama.cpp Source Code and Build Code
```
cd ~/$BUILD_MMOJO_SERVER_DIR
sed -i -e 's/#if defined(_WIN32) || defined(__COSMOPOLITAN__)/#if defined(_WIN32)/g' miniaudio/miniaudio.h
sed -i -e 's/arg.cpp/arg-mmojo.cpp/g' common/CMakeLists.txt
sed -i -e 's/common.cpp/common-mmojo.cpp/g' common/CMakeLists.txt
sed -i -e 's/server.cpp/server-mmojo.cpp/g' tools/server/CMakeLists.txt
sed -i -e 's/set(TARGET llama-server)/set(TARGET mmojo-server)/g' tools/server/CMakeLists.txt
sed -i -e 's/loading.html/loading-mmojo.html/g' tools/server/CMakeLists.txt
if ! grep -q "#include <cstdlib>" "tools/mtmd/deprecation-warning.cpp" ; then
  sed -i '3i #include <cstdlib>' tools/mtmd/deprecation-warning.cpp
fi
if ! grep -q "#include <algorithm>" "src/llama-hparams.cpp" ; then
  sed -i '4i #include <algorithm>' src/llama-hparams.cpp
fi
printf "\n**********\n*\n* FINISHED: Fix llama.cpp Source and Build Code.\n*\n**********\n\n"
```

---
### Customize WebUI
```
APP_NAME='Mmojo Chat'
sed -i -e "s/<title>.*<\/title>/<title>$APP_NAME<\/title>/g" tools/server/webui/index.html
sed -i -e "s/>llama.cpp<\/div>/>$APP_NAME<\/div>/g" tools/server/webui/src/components/Header.tsx
cd tools/server/webui
npm i
npm run build
cd ~/$BUILD_MMOJO_SERVER_DIR
sed -i -e "s/\[\[UPDATED\]\]/$TODAY/g" completion-ui/completion/scripts.js
sed -i -e "s/\[\[UPDATED\]\]/$TODAY/g" completion-ui/completion/bookmark-scripts.js
printf "\n**********\n*\n* FINISHED: Customize WebUI.\n*\n**********\n\n"
```

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

printf "\n**********\n*\n* FINISHED: Build llama.cpp.\n*\n**********\n\n"
```

**Optional:** Test the build. If you've previously downloaded a model to the `1-DOWNLOAD` folder, you can test the build.
```
./build-platform/bin/mmojo-server --model ~/$DOWNLOAD_DIR/Google-Gemma-1B-Instruct-v3-q8_0.gguf \
    --path completion-ui/ --host 0.0.0.0 --port 8080
```

---
### Next Step: Build Mmojo Server with Cosmopolitan

You've cloned the OpenSSL repo, fixed a couple Cosmopolitan-related issues, and built it with Cosmopolitan. You don't need to do this every time you build Mmojo Server.

Next step: [5. Build Mmojo Server with Cosmopolitan](5-Build-Mmojo-Server-with-Cosmopolitan.md).
