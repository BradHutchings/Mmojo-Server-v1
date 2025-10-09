## 5b. Build Mmojo Server - Native

Brad Hutchings<br/>
brad@bradhutchings.com

The fifth step in building Mmojo Server is to build the Mmojo Server.

In this second substep, we will build a native Mmojo Server for the build platform. You don't need to do this. It's a good check to make sure the mmojo-server code is in order. 

Skip ahead to: [5c. Build Mmojo Server with Cosmopolitan](5c-Build-Mmojo-Server-with-Cosmopolitan.md).

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
# if [ -z "$TODAY" ]; then
#  export TODAY=$(date +%Y-%m-%d)
# fi
printf "\n**********\n*\n* FINISHED: Environment Variables.\n*\n**********\n\n"
```

_Note that if you copy each code block from the guide and paste it into your terminal, each block ends with a message so you won't lose your place in this guide._

**Optional:** Set `$EXTRA_FLAGS` for profiling.
```
EXTRA_FLAGS=" -pg "
```


---
### Build Mmojo Server for build platform.
We now use CMake to build Mmojo Server.
```
cd ~/$BUILD_MMOJO_SERVER_DIR
export PATH=$SAVE_PATH
if [ -z "$EXTRA_FLAGS" ]; then
    unset CC; export CC
    unset CXX; export CXX
else
    export CC="cc $EXTRA_FLAGS "
    export CXX="c++ $EXTRA_FLAGS "
fi
cmake -B build-platform -DBUILD_SHARED_LIBS=OFF -DLLAMA_CURL=OFF -DLLAMA_OPENSSL=ON
cmake --build build-platform --config Release

printf "\n**********\n*\n* FINISHED: Build Mmojo Server for build platform.\n*\n**********\n\n"
```

**Optional:** Test the build. If you've previously downloaded a model to the `1-DOWNLOAD` folder, you can test the build.
```
./build-platform/bin/mmojo-server --model ~/$DOWNLOAD_DIR/Google-Gemma-1B-Instruct-v3-q8_0.gguf \
    --path completion-ui/ --default-ui-endpoint "chat" --host 0.0.0.0 --port 8080 --batch-size 64 \
    --threads-http 8 --ctx-size 0 --mlock
```

**Optional:** If you're profiling, get some profile output.
```
gprof build-platform/bin/mmojo-server gmon.out > build-platform/profile.txt
more build-platform/profile.txt
```

---
### (Optional) Copy completion-ui to Local Space
After testing the completion UI, copy it to local space. These commands use Brad's `mount-host-share.sh` script and `/mnt/hyperv` share.

```
cd ~/$BUILD_MMOJO_SERVER_DIR
mount-host-share.sh
sudo cp -r completion-ui-original /mnt/hyperv/web-apps/completion-ui
# sudo sed -i -e "s/$TODAY/\[\[UPDATED\]\]/g" /mnt/hyperv/web-apps/completion-ui/completion/scripts.js
# sudo sed -i -e "s/$TODAY/\[\[UPDATED\]\]/g" /mnt/hyperv/web-apps/completion-ui/completion/bookmark-scripts.js
```

---
### Next Step: Build Mmojo Server with Cosmopolitan

You've built the `mmojo-server` application for the build platform.

Next step: [5c. Build Mmojo Server with Cosmopolitan](5c-Build-Mmojo-Server-with-Cosmopolitan.md).
