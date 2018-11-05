#!/bin/bash
FOLDERS=$(ls -d ../webapp-*)
for FOLDER in $FOLDERS; do
	echo "# $FOLDER"
	rsync -ai common/ $FOLDER/
done