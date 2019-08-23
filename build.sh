#!/usr/bin/env sh

set -eu

APPS="admin auth compose messaging"
FLAVOUR=${FLAVOUR:-"corteza"}
APP_VERSION=${APP_VERSION:-"master"}

echo "Unpacking ${FLAVOUR}-webapp-one@${APP_VERSION}"
mkdir -p dist/
tar -xjf ${FLAVOUR}-webapp-one-${APP_VERSION}.tar.bz2 -C dist/

for APP in $APPS; do
	echo "Unpacking ${FLAVOUR}-webapp-${APP}@${APP_VERSION}"
	mkdir -p dist/${APP}
	tar -xjf ${FLAVOUR}-webapp-${APP}-${APP_VERSION}.tar.bz2 -C dist/${APP}
done;

rm ${FLAVOUR}-webapp-*.tar.bz2
