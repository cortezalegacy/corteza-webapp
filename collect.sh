#!/usr/bin/env sh

set -eu

APPS="one admin auth compose messaging"
FLAVOUR=${FLAVOUR:-"corteza"}
APP_VERSION=${APP_VERSION:-"master"}

for APP in $APPS; do
	echo "Veryfing ${APP}@${APP_VERSION}"
	bzip2 -tv /var/build/${FLAVOUR}-webapp-${APP}-${APP_VERSION}.tar.bz2
done;


echo "Copy webapps"
cp -v /var/build/${FLAVOUR}-webapp-*-${APP_VERSION}.tar.bz2 ./
