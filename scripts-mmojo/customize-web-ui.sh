#!/bin/bash

# This script rebuilds the chat web UI so that it can be customized and used with mmojo-server.
# -Brad

# Todo: Set $TODAY locally in this script. In the build process, duplicate the completion-ui directory as completion-ui-original.
# Copy that directory to local share. Remove the replacement of $TODAY. -Brad 2025-10-09

APP_NAME='Mmojo Chat'
sed -i -e "s/>llama.cpp<\/h1>/>$APP_NAME<\/h1>/g" tools/server/webui/src/lib/components/app/chat/ChatScreen/ChatScreen.svelte
sed -i -e "s/>llama.cpp<\/h1>/>$APP_NAME<\/h1>/g" tools/server/webui/src/lib/components/app/chat/ChatSidebar/ChatSidebar.svelte
cp tools/server/public/loading-mmojo.html ./loading-mmojo.html
SAVE_WD=$(pwd)
cd tools/server/webui
npm i
npm run build
cd $SAVE_WD
mv loading-mmojo.html tools/server/public/loading-mmojo.html
TODAY=$(date +%Y-%m-%d)
cp -r completion-ui completion-ui-original
sed -i -e "s/\[\[UPDATED\]\]/$TODAY/g" completion-ui/completion/scripts.js
sed -i -e "s/\[\[UPDATED\]\]/$TODAY/g" completion-ui/completion/bookmark-scripts.js
