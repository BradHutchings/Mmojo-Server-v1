## 1. Download

Brad Hutchings<br/>
brad@bradhutchings.com

The first step in building Mmojo Server is to download some files we will need. You don't need to do this every time you build Mmojo Server.

Skip ahead to: [2. Build Cosmopolitan](2-Build-Cosmopolitan.md).

---
### Environment Variables

Let's define some environment variables:
```
DOWNLOAD_DIR="1-DOWNLOAD"
if [ -z "$SAVE_PATH" ]; then
  export SAVE_PATH=$PATH
fi
if [[ -z "$TODAY" ]]; then
  TODAY=$(date +%Y-%m-%d)
fi
printf "\n**********\n*\n* FINISHED: Environment Variables.\n*\n**********\n\n"
```

_Note that if you copy each code block from the guide and paste it into your terminal, each block ends with a message so you won't lose your place in this guide._

---
### Download Models
Download the models from Hugging Face:
```
MODEL_FILE="Google-Gemma-1B-Instruct-v3-q8_0.gguf"
mkdir -p ~/$DOWNLOAD_DIR
cd ~/$DOWNLOAD_DIR
URL="https://huggingface.co/bradhutchings/Mmojo-Server/resolve/main/models/$MODEL_FILE?download=true"
if [ ! -f $MODEL_FILE ]; then wget $URL --show-progress --quiet -O $MODEL_FILE ; fi
printf "\n**********\n*\n* FINISHED: Download Models.\n*\n**********\n\n"
```


---
### [Brad] Copy Models from Share
If you're lucky enough to be using Brad's environment, copying from a local file share is faster than downloading from Hugging Face.

Mount the share:
```
mount-host-share.sh
ls -al /mnt/hyperv
printf "\n**********\n*\n* FINISHED: Mount the share.\n*\n**********\n\n"
```

Copy the models:
```
MODEL_FILE="Google-Gemma-1B-Instruct-v3-q8_0.gguf"
mkdir -p ~/$DOWNLOAD_DIR
cd ~/$DOWNLOAD_DIR
cp /mnt/hyperv/models/$MODEL_FILE ~/$DOWNLOAD_DIR
printf "\n**********\n*\n* FINISHED: Copy Models from Share.\n*\n**********\n\n"
```

---
### Next Step: Build Cosmopolitan
Congratulations! You have downloaded files you will need and are ready to build Cosmopolitan.

Next step: [2. Build Cosmopolitan](2-Build-Cosmopolitan.md).

