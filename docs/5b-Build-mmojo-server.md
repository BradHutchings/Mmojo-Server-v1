## 5b. Build mmojo-server

Brad Hutchings<br/>
brad@bradhutchings.com

The fifth step in building Mmojo Server is to build the `mmojo-server` executables.

In this subsetp, we will build `mmojo-server` for your build environment platform. You don't need to do this. You can use it to test and debug features of mmojo-server that are not specific to any particular build.

Skip ahead to: [5c. Build mmojo-server-cosmo](5c-Build-mmojo-server-cosmo.md).

---
### Environment Variables

Let's define some environment variables:
```
DOWNLOAD_DIR="1-DOWNLOAD"
BUILD_COSMOPOLITAN_DIR="2-BUILD-cosmopolitan"
BUILD_LLAMAFILE_DIR="3-BUILD-llamafile"
BUILD_OPENSSSL_DIR="4-BUILD-openssl"
BUILD_MMOJO_SERVER_DIR="5-BUILD-mmojo"
EXTRA_FLAGS=""
if [ -z "$SAVE_PATH" ]; then
  export SAVE_PATH=$PATH
fi
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

**Optional:** Test the build. Requires previously downloaded model to the `1-DOWNLOAD` directory.
```
rm -f ./build-platform/bin/mmojo-server-args
./build-platform/bin/mmojo-server --model ~/$DOWNLOAD_DIR/Google-Gemma-1B-Instruct-v3-q8_0.gguf \
    --path completion-ui/ --default-ui-endpoint "chat" --host 0.0.0.0 --port 8080 --batch-size 64 \
    --threads-http 8 --ctx-size 0 --mlock
```

**Optional:** Test the build with a `mmojo-server-args` file. Requires previously downloaded model to the `1-DOWNLOAD` directory.
```
cat << EOF > ./build-platform/bin/mmojo-server-args
--model
$HOME/$DOWNLOAD_DIR/Google-Gemma-1B-Instruct-v3-q8_0.gguf
--host
0.0.0.0
--port
8080
--ctx-size
0
--threads-http
8
--batch-size
64
--batch-sleep-ms
0
--path
$(pwd)/completion-ui
--default-ui-endpoint
chat
--mlock
...
EOF
./build-platform/bin/mmojo-server 
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
```

---
### Next Step: Build mmojo-server-cosmo

You've built the `mmojo-server` application for your build environment platform.

Next step: [5c. Build mmojo-server-cosmo](5c-Build-mmojo-server-cosmo.md).
