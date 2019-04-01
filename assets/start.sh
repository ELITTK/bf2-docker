#!/bin/sh

TMP='/home/bf2/tmp'
VOLUME='/home/bf2'

SRC="$TMP/srv/"
DEST="$VOLUME/srv/"

# Move from temp to persisted folder (symlink instead?)
if [ "$(ls -A $DEST)" ]; then
    echo "$DEST is not empty"
else
    # Move server files (-n without overwriting)
    echo "$DEST is empty. Moving server files..."
    mv -n $SRC* $DEST

    # Overwrite settings file
    echo "Overwriting settings file..."
    mv "$TMP/serversettings.con" "$DEST/mods/bf2/settings/"

    # Delete our tmp directory
    echo "Deleting tmp directory..."
    rm -rf $SRC
fi

# Set permissions
echo "Setting execute permissions..."
cd $DEST
chmod +x ./start.sh
chmod +x ./start_bf2hub.sh
chmod +x ./bin/amd-64/bf2
chmod +x ./bin/amd-64/libbf2hub.so
chmod +x ./bin/ia-32/bf2
chmod +x ./bin/ia-32/libbf2hub.so

# Start Battlefield 2 server
echo "Starting Battlefield 2 server..."
export TERM=xterm
./start_bf2hub.sh >> log.txt