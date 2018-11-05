#!/bin/bash
FOLDERS=$(ls -d ../webapp-* | grep -v messaging)
for FOLDER in $FOLDERS; do
	echo "# $FOLDER"
	rsync -ai common/ $FOLDER/
done