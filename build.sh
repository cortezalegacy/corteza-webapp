#!/usr/bin/env sh

set -eu

APPS="admin auth compose messaging"

BRANCH=${1:-"master"}
FLAVOUR=${FLAVOUR:-"corteza"}

echo "Unpacking unify"
mkdir -p dist/
tar -xjf ${FLAVOUR}-webapp-unify-${BRANCH}.tar.bz2 -C dist/

for APP in $APPS; do
	echo "Unpacking $APP"
	mkdir -p dist/${APP}
	tar -xjf ${FLAVOUR}-webapp-${APP}-${BRANCH}.tar.bz2 -C dist/${APP}
done;

rm ${FLAVOUR}-webapp-*.tar.bz2

mv dist webapp
