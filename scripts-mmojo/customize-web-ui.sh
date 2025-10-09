#!/bin/bash

# This script rebuilds the chat web UI so that it can be customized and used with mmojo-server.
# -Brad

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
