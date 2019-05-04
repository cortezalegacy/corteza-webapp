#!/usr/bin/env sh

set -eu

BRANCH=${1:-"master"}

APPS="admin auth compose messaging"

echo "Unpacking unify"
mkdir -p dist/
tar -xjf webapp-unify-${BRANCH}.tar.bz2 -C dist/

for APP in $APPS; do
	echo "Unpacking $APP"
	mkdir -p dist/${APP}
	tar -xjf webapp-${APP}-${BRANCH}.tar.bz2 -C dist/${APP}
done;

rm webapp-*.tar.bz2
