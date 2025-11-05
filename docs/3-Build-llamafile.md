## 3. Build llamafile

Brad Hutchings<br/>
brad@bradhutchings.com

The third step in building Mmojo Server is to clone the llamafile repo and build it. This will give us access to llamafile's `zipalign` tool for packaging `mmojo-server-one`. You don't need to do this every time you build Mmojo Server.

Skip ahead to: [4. Build OpenSSL with Cosmopolitan](4-Build-OpenSSL-with-Cosmopolitan.md).

---
### Environment Variables

Let's define some environment variables:
```
DOWNLOAD_DIR="21-DOWNLOAD"
BUILD_COSMOPOLITAN_DIR="22-BUILD-cosmopolitan"
BUILD_LLAMAFILE_DIR="23-BUILD-llamafile"
printf "\n**********\n*\n* FINISHED: Environment Variables.\n*\n**********\n\n"
```

_Note that if you copy each code block from the guide and paste it into your terminal, each block ends with a message so you won't lose your place in this guide._

---
### Clone and Build llamafile
We clone and build llamafile so we will have access to its custom `zipalign` tool for packaging. 

```
cd ~
git clone https://github.com/Mozilla-Ocho/llamafile $BUILD_LLAMAFILE_DIR
cd $BUILD_LLAMAFILE_DIR
# Revert to May, 2025 release
git checkout ff0c02e6c560d88324966e88a718485989b41c1e
make -j8
make install PREFIX=.
printf "\n**********\n*\n* FINISHED: Clone and Build llamafile.\n*\n**********\n\n"
```

Now, `zipalign` exists at `~/23-BUILD-llamafile/bin/zipalign`.

---
### Next Step: Build OpenSSL with Cosmopolitan

You've cloned the llamafile repo and built it so you'll have access to the `zipalign` tool for packaging `mmojo-server-one`. You don't need to do this every time you build Mmojo Server.

Next step: [4. Build OpenSSL with Cosmopolitan](4-Build-OpenSSL-with-Cosmopolitan.md).
