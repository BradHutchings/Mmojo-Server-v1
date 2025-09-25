## 4a. Prepare to Build Mmojo Server

Brad Hutchings<br/>
brad@bradhutchings.com

The fourth step in building Mmojo Server is to build the Mmojo Server.

In this first substep, we will clone the mmojo-server repo, fix problems that affect building with Cosmopolitan, and add some features for Mmojo Server.

---
### Environment Variables

Let's define some environment variables:
```
DOWNLOAD_DIR="1-DOWNLOAD"
BUILD_COSMOPOLITAN_DIR="2-BUILD-cosmopolitan"
BUILD_OPENSSSL_DIR="3-BUILD-openssl"
BUILD_MMOJO_SERVER_DIR="4-BUILD-mmojo-server"
BUILD_MMOJO_SERVER_DIR="4-BUILD-mmojo"
COSMO_DIR="$BUILD_COSMOPOLITAN_DIR/cosmocc"
if [ -z "$SAVE_PATH" ]; then
  export SAVE_PATH=$PATH
fi
if [ -z "$TODAY" ]; then
  TODAY=$(date +%Y-%m-%d)
fi
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

---
### Fix llama.cpp Source Code and Build Code
```
cd ~/$BUILD_MMOJO_SERVER_DIR
sed -i -e 's/#if defined(_WIN32) || defined(__COSMOPOLITAN__)/#if defined(_WIN32)/g' miniaudio/miniaudio.h
sed -i -e 's/arg.cpp/arg-mmojo.cpp/g' common/CMakeLists.txt
sed -i -e 's/common.cpp/common-mmojo.cpp/g' common/CMakeLists.txt
sed -i -e 's/server.cpp/server-mmojo.cpp/g' tools/server/CMakeLists.txt
sed -i -e 's/set(TARGET llama-server)/set(TARGET mmojo-server)/g' tools/server/CMakeLists.txt
sed -i -e 's/loading.html/loading-mmojo.html/g' tools/server/CMakeLists.txt
sed -i -e 's/find_package(OpenSSL REQUIRED)/# find_package(OpenSSL REQUIRED)/g' tools/server/CMakeLists.txt
sed -i -e 's/PRIVATE OpenSSL::SSL OpenSSL::Crypto/PRIVATE libssl.a libcrypto.a/g' tools/server/CMakeLists.txt
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

**Suggested:** Rollback the `tools/server/webui` to the pre-Svelte version. The new Svelte UI doesn't like running on non-root web server path. We'll remove this step when the new UI is fixed upstream in llama.cpp.

```
rm -r -f tools/server/webui
git checkout 6c019cb04e86e2dacfe62ce7666c64e9717dde1f tools/server/webui/

APP_NAME='Mmojo Chat'
sed -i -e "s/>.*llama.cpp.*</>$APP_NAME</g" tools/server/webui/index.html
sed -i -e "s/>.*llama.cpp.*</>$APP_NAME</g" tools/server/webui/src/components/Header.tsx
```

The `npm build` command writes over `tools/server/public`, so we save `loading-mmojo.html` and
copy it back in after.

```
APP_NAME='Mmojo Chat'
sed -i -e "s/>llama.cpp<\/h1>/>$APP_NAME<\/h1>/g" tools/server/webui/src/lib/components/app/chat/ChatScreen/ChatScreen.svelte
sed -i -e "s/>llama.cpp<\/h1>/>$APP_NAME<\/h1>/g" tools/server/webui/src/lib/components/app/chat/ChatSidebar/ChatSidebar.svelte
cp tools/server/public/loading-mmojo.html ./loading-mmojo.html
cd tools/server/webui
npm i
npm run build
cd ~/$BUILD_MMOJO_SERVER_DIR
mv loading-mmojo.html tools/server/public/loading-mmojo.html
sed -i -e "s/\[\[UPDATED\]\]/$TODAY/g" completion-ui/completion/scripts.js
sed -i -e "s/\[\[UPDATED\]\]/$TODAY/g" completion-ui/completion/bookmark-scripts.js
printf "\n**********\n*\n* FINISHED: Customize WebUI.\n*\n**********\n\n"
```

#### Uh. Oh. npm Spit Out Errors

You may have an earlier version of `npm` and `nodejs` installed on your build machine than are required
for that customization step. If you're running Linux or macOS, these steps should clean that up.

**ONLY RUN THESE IF YOU HAD PROBLEMS IN THE PREVIOUS STEP!!** Then rerun the previous step.

```
cd ~
sudo apt remove nodejs npm -y
sudo apt install nodejs npm -y
sudo npm install -g node@latest
sudo npm install -g npm@latest
cd ~/$BUILD_MMOJO_SERVER_DIR
```

---
### Next Step: Build Mmojo Server - Native

You've cloned the Mmojo Server repo and fixed a couple Cosmopolitan-related issues. You are ready to build Mmojo Server now.

Next step: [4b. Build Mmojo Server - Native](4b-Build-Mmojo-Server-Native.md).
