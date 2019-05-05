#!/bin/sh
# Run some startup scripts
ls /startup/*.sh | sh

if [ ! -z "$1" ]; then
	echo "Running: $@"
	exec "$@"
else
	echo "Running: nginx"
	exec nginx -g "daemon off;"
fi
