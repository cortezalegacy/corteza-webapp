#!/usr/bin/env sh

set -eu

APPS="one admin auth compose messaging"
BRANCH=${DRONE_BRANCH:-"master"}
FLAVOUR=${FLAVOUR:-"corteza"}

for APP in $APPS; do
	echo "Veryfing $APP"
	bzip2 -tv /var/build/${FLAVOUR}-webapp-${APP}-${BRANCH}.tar.bz2
done;


echo "Copy webapps"
cp -v /var/build/${FLAVOUR}-webapp-*-${BRANCH}.tar.bz2 ./
