## 6a. Package Mmojo Server

Brad Hutchings<br/>
brad@bradhutchings.com

The sixth step in building Mmojo Server is to package the `mmojo-server` Actual Portable Executable (APE) for deployment.

We are going to package `mmojo-server` without an embedded `.gguf` model file.

If you would like to package `mmojo-server-one` with an embedded `.gguf` model file, use this step instead:
- [6b. Package Mmojo Server One](6b-Package-Mmojo-Server-One.md).

---
### Environment Variables

Let's define some environment variables:
```
DOWNLOAD_DIR="1-DOWNLOAD"
BUILD_COSMOPOLITAN_DIR="2-BUILD-cosmopolitan"
BUILD_LLAMAFILE_DIR="3-BUILD-llamafile"
BUILD_OPENSSSL_DIR="4-BUILD-openssl"
BUILD_MMOJO_SERVER_DIR="5-BUILD-mmojo"
PACKAGE_DIR="6a-PACKAGE-mmojo-server"

MMOJO_SERVER="mmojo-server"
MMOJO_SERVER_ZIP="mmojo-server.zip"
DEFAULT_ARGS="default-args"

if [ -z "$SAVE_PATH" ]; then
  export SAVE_PATH=$PATH
fi
if [ -z "$TODAY" ]; then
  export TODAY=$(date +%Y-%m-%d)
fi
printf "\n**********\n*\n* FINISHED: Environment Variables.\n*\n**********\n\n"
```

_Note that if you copy each code block from the guide and paste it into your terminal, each block ends with a message so you won't lose your place in this guide._

---
### Create PACKAGE Directory

Next, let's create a directory where we'll package `mmojo-server`. We copy `mmojo-server` to the directory as `mmojo-server.zip` because the `zip` command will not add or delete files to an archive that does not have a `.` in the name. Crazy, right?
```
cd ~
rm -r -f ~/$PACKAGE_DIR
mkdir -p $PACKAGE_DIR
cp ~/$BUILD_MMOJO_SERVER_DIR/$MMOJO_SERVER ~/$PACKAGE_DIR/$MMOJO_SERVER_ZIP
cd ~/$PACKAGE_DIR
printf "\n**********\n*\n* FINISHED: Create PACKAGE Directory.\n*\n**********\n\n"
```

---
### Examine Contents of Zip Archive

Look at the contents of the `mmojo.server.zip` archive:
```
unzip -l $MMOJO_SERVER_ZIP 
printf "\n**********\n*\n* FINISHED: Examine Contents of Zip Archive.\n*\n**********\n\n"
```

---
### Delete Extraneous Timezone Files

You should notice a bunch of extraneous timezone related files in `/usr/*`. Let's get rid of those:
```
zip -d $MMOJO_SERVER_ZIP "/usr/*"
printf "\n**********\n*\n* FINISHED: Delete Extraneous Timezone Files.\n*\n**********\n\n"
```

#### Verify Contents of Zip Archive

Verify that these files are no longer in the archive:
```
unzip -l $MMOJO_SERVER_ZIP 
printf "\n**********\n*\n* FINISHED: Verify Contents of Zip Archive.\n*\n**********\n\n"
```

---
### Add Certs to Archive

Add self-signed certs to the archive. CA cert is added to the website folder.
```
mkdir certs
cp /mnt/hyperv/Mmojo-Raspberry-Pi/Mmojo-certs/mmojo.local.crt certs
cp /mnt/hyperv/Mmojo-Raspberry-Pi/Mmojo-certs/mmojo.local.key certs
cp /mnt/hyperv/Mmojo-Raspberry-Pi/Mmojo-certs/selfsignCA.crt certs
zip -0 -r $MMOJO_SERVER_ZIP certs/*
printf "\n**********\n*\n* FINISHED: Add Certs to Archive.\n*\n**********\n\n"
```

#### Verify certs Directory in Archive

Verify that the archive has your certs:
```
unzip -l $MMOJO_SERVER_ZIP 
printf "\n**********\n*\n* FINISHED: Verify certs Directory in Archive.\n*\n**********\n\n"
```

---
### Create website Directory in Archive

`llama.cpp` has a built in chat UI. If you'd like to provide a custom UI, you should add a `website` directory to the `mmojo-server` archive. `llama.cpp`'s chat UI is optimized for serving inside the project's source code. But we can copy the unoptimized source:
```
mkdir website
cp -r ~/$BUILD_MMOJO_SERVER_DIR/completion-ui/* website
cp /mnt/hyperv/Mmojo-Raspberry-Pi/Mmojo-certs/selfsignCA.crt website/CA.crt
zip -0 -r $MMOJO_SERVER_ZIP website/*
printf "\n**********\n*\n* FINISHED: Create website Directory in Archive.\n*\n**********\n\n"
```

#### Verify website Directory in Archive

Verify that the archive has your website:
```
unzip -l $MMOJO_SERVER_ZIP 
printf "\n**********\n*\n* FINISHED: Verify website Directory in Archive.\n*\n**********\n\n"
```

---
### Create default-args File in Archive

A `default-args` file in the archive can specify sane default parameters. The format of the file is parameter name on a line, parameter value on a line, rinse, repeat. End the file with a `...` line to include user specified parameters.

We don't yet support including the model inside the zip archive (yet). That has a 4GB size limitation on Windows anyway, as `.exe` files cannot exceed 4GB. So let's use an adjacent file called `model.gguf`.

We will serve on localhost, port 8080 by default for safety. The `--ctx-size` parameter is the size of the context window. This is kinda screwy to have as a set size rather than a maximum because the `.gguf` files now have the training context size in metadata. We set it to 8192 to be sensible. The `--threads-http` parameter ensures that the browser can ask for all the image files in our default UI at once.
```
cat << EOF > $DEFAULT_ARGS
-m
model.gguf
--host
127.0.0.1
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
/zip/website
--default-ui-endpoint
chat
--ssl-key-file
/zip/certs/mmojo.local.key
--ssl-cert-file
/zip/certs/mmojo.local.crt
...
EOF
zip -0 -r $MMOJO_SERVER_ZIP $DEFAULT_ARGS
printf "\n**********\n*\n* FINISHED: Create Default args File in Archive.\n*\n**********\n\n"
```

#### Verify default-args File in Archive

Verify that the archive contains the `default-args` file:
```
unzip -l $MMOJO_SERVER_ZIP 
printf "\n**********\n*\n* FINISHED: Verify default-args File in Archive.\n*\n**********\n\n"
```

---
### Remove .zip Extension, Delete Local Files

Remove the `.zip` from our working file and delete the local copy of the model file:
```
mv $MMOJO_SERVER_ZIP $MMOJO_SERVER
rm -r -f certs default-args website
printf "\n**********\n*\n* FINISHED: Remove .zip Extension, Delete Local Files.\n*\n**********\n\n"
```

---
### Copy Model

Let's copy a small model. We'll use Google Gemma 1B Instruct v3, a surprisingly capable tiny model.
```
MODEL_FILE="Google-Gemma-1B-Instruct-v3-q8_0.gguf"
cp ~/$DOWNLOAD_DIR/$MODEL_FILE model.gguf
printf "\n**********\n*\n* FINISHED: Copy Model.\n*\n**********\n\n"
```

---
### Test Run

Now we can test run `mmojo-server`, listening on localhost:8080.
```
./$MMOJO_SERVER
```

After starting up and loading the model, it should display:

**main: server is listening on https://127.0.0.1:8080 - starting the main loop**<br/>
**srv  update_slots: all slots are idle**

Hit `ctrl-C` on your keyboard to stop it.

#### Test Run on Public Interfaces

If you'd like it to listen on all available interfaces, so you can connect from a browser on another computer:
```
./$MMOJO_SERVER --host 0.0.0.0
```

After starting up and loading the model, it should display:

**main: server is listening on https://0.0.0.0:8080 - starting the main loop**<br/>
**srv  update_slots: all slots are idle**

Hit `ctrl-C` on your keyboard to stop it.

---
### Copy mmojo-server for Deployment
Congratulations! You are ready to copy `mmojo-server` executable to the share for deployment. These commands use Brad's `mount-host-share.sh` script and `/mnt/hyperv` share.

```
mount-host-share.sh
sudo cp $MMOJO_SERVER /mnt/hyperv/Mmojo-Server/$MMOJO_SERVER
sudo cp $MMOJO_SERVER /mnt/hyperv/Mmojo-Server/$MMOJO_SERVER.exe
sudo cp $MMOJO_SERVER /mnt/hyperv/Mmojo-Raspberry-Pi/Mmojo-LLMs/$MMOJO_SERVER
printf "\n**********\n*\n* FINISHED: Copy mmojo-server for Deployment.\n*\n**********\n\n"
```
