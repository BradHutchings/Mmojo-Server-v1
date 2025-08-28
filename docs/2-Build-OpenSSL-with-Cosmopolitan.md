## 2. Build OpenSSL with Cosmopolitan

Brad Hutchings<br/>
brad@bradhutchings.com

The second step in building Mmojo Server is to clone the OpenSSL repo, fix problems that affect building with Cosmopolitan, and build it. You don't need to do this every time you build Mmojo Server.

Skip ahead to: 3. Build Native Mmojo Server.

---
### Environment Variables

Let's define some environment variables:
```
DOWNLOAD_DIR="0-DOWNLOAD"
BUILD_COSMOPOLITAN_DIR="1-BUILD-cosmopolitan"
BUILD_OPENSSSL_DIR="2-BUILD-openssl"
COSMO_DIR="$BUILD_COSMOPOLITAN_DIR/cosmocc"
if [ -z "$SAVE_PATH" ]; then
  export SAVE_PATH=$PATH
fi
TODAY=$(date +%Y-%m-%d)
printf "\n**********\n*\n* FINISHED: Environment Variables.\n*\n**********\n\n"
```

_Note that if you copy each code block from the guide and paste it into your terminal, each block ends with a message so you won't lose your place in this guide._

---
### Create Build Directory
```
mkdir -p ~/$BUILD_OPENSSSL_DIR
cd ~/$BUILD_OPENSSSL_DIR
cp -r ~/$COSMO_DIR .
printf "\n**********\n*\n* FINISHED: Create Build Directory.\n*\n**********\n\n"
```

---
### Prepare to Build OpenSSL with Cosmo - Both platforms
```
export PATH="$(pwd)/cosmocc/bin:$SAVE_PATH"
export CC="cosmocc -I$(pwd)/cosmocc/include -L$(pwd)/cosmocc/lib"
export CXX="cosmocc -I$(pwd)/cosmocc/include \
    -I$(pwd)/cosmocc/include/third_party/libcxx \
    -L$(pwd)/cosmocc/lib -L$(pwd)/openssl"
export AR="cosmoar"
# export UNAME_S="cosmocc"
# export UNAME_P="cosmocc"
# export UNAME_M="cosmocc"
if ! grep -q "#include <algorithm>" "src/llama-hparams.cpp" ; then
  sed -i '4i #include <algorithm>' src/llama-hparams.cpp
fi
export PATH=$SAVE_PATH
printf "\n**********\n*\n* FINISHED: Prepare to Build llama.cpp with Cosmo.\n*\n**********\n\n"
```

---
### Build openssl with Cosmo
We need cross-architectire `libssl` and `libcrypto` static libraries to support SSL in `mmojo-server`.
```
cd ~/$BUILD_OPENSSSL_DIR
cp -r /usr/include/openssl/ ./cosmocc/include/
cp -r /usr/include/x86_64-linux-gnu/openssl/* ./cosmocc/include/openssl
cp -r /usr/include/aarch64-linux-gnu/openssl/* ./cosmocc/include/openssl
git clone https://github.com/openssl/openssl.git
cd ~/$BUILD_OPENSSSL_DIR/openssl
./Configure no-asm no-dso no-afalgeng no-shared no-pinshared no-apps
make
cd ~/$BUILD_OPENSSSL_DIR
printf "\n**********\n*\n* FINISHED: Build openssl with Cosmo.\n*\n**********\n\n"
```

---
### Next Step: Build OpenSSL with Cosmopolitan

You've cloned the OpenSSL repo, fixed a couple Cosmopolitan-related issues, and built it with Cosmopolitan. You don't need to do this every time you build Mmojo Server.

Next step: 3. Build Native Mmojo Server.
