## 2. Build Cosmopolitan

Brad Hutchings<br/>
brad@bradhutchings.com

The second step in building Mmojo Server is to clone the Cosmopolitan repo, fix known problems, and build it. You don't need to do this every time you build Mmojo Server.

Skip ahead to: [3. Build llamafile](3-Build-llamfile.md).

---

### Environment Variables

Let's define some environment variables:
```
DOWNLOAD_DIR="1-DOWNLOAD"
BUILD_COSMOPOLITAN_DIR="2-BUILD-cosmopolitan"
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
### Clone Cosmopolitan Repo, Build Locally (DO THIS ONCE)
Clone Cosmopolitan repo into a `~\2-BUILD-cosmopolitan` directory, fix bugs, then build Cosmopolitan. Build this once, and leave the `~\2-BUILD-cosmopolitan` directory between builds.
```
cd ~
mkdir -p ~/$DOWNLOAD_DIR
mkdir -p ~/$BUILD_COSMOPOLITAN_DIR
git clone https://github.com/jart/cosmopolitan.git $BUILD_COSMOPOLITAN_DIR
cd ~/$BUILD_COSMOPOLITAN_DIR
# Edit the memchr_sse() function to check params.
sed -i '39i \  if ((s == NULL) || (n == 0)) return 0;' libc/intrin/memchr.c
tool/cosmocc/package.sh
printf "\n**********\n*\n* FINISHED: Clone Cosmopolitan Repo, Build Locally.\n*\n**********\n\n"
```

---
### Next Step: Build llamfile

You've cloned the Cosmopolitan repo, fixed a couple issues, and built it. You don't need to do this every time you build Mmojo Server.

Next step: [3. Build llamfile](3-Build-llamafile.md).
