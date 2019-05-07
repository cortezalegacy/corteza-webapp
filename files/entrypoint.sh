#!/bin/sh

set -eu

run-parts --exit-on-error /start.d

if [ ! -z "${1:-}" ]; then
	exec "$@"
else
	exec nginx -g "daemon off;"
fi
