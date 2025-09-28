## 3. Build llamafile

Brad Hutchings<br/>
brad@bradhutchings.com

The third step in building Mmojo Server is to clone the llamafile repo and build it. This will give us access to llamafile's `zipalign` tool. You don't need to do this every time you build Mmojo Server.

Skip ahead to: [4. Build OpenSSL with Cosmopolitan](4-Build-OpenSSL-with-Cosmopolitan.md).

---
### Environment Variables

Let's define some environment variables:
```
DOWNLOAD_DIR="1-DOWNLOAD"
BUILD_COSMOPOLITAN_DIR="2-BUILD-cosmopolitan"
BUILD_LLAMAFILE_DIR="3-BUILD-llamafile"
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

---
### Clone and Build llamafile
```
git clone https://github.com/Mozilla-Ocho/llamafile $BUILD_LLAMAFILE_DIR
cd $BUILD_LLAMAFILE_DIR
make -j8
make install PREFIX=.
printf "\n**********\n*\n* FINISHED: Clone and Build llamafile.\n*\n**********\n\n"
```

Now, `zipalign` exists at `~/3-BUILD-llamafile/bin/zipalign`.

---
### Next Step: Build OpenSSL with Cosmopolitan

You've cloned the Cosmopolitan repo, fixed a couple issues, and built it. You don't need to do this every time you build Mmojo Server.

Next step: [4. Build OpenSSL with Cosmopolitan](4-Build-OpenSSL-with-Cosmopolitan.md).
