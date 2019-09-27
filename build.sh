#!/usr/bin/env bash

set -eu

APPS="one admin auth compose messaging"
FLAVOUR=${FLAVOUR:-"corteza"}
APP_VERSION=${APP_VERSION:-""}
BUILD_DIR=/var/build

if [ "" == "${APP_VERSION}" ]; then
  echo "Error: APP_VERSION is empty"
  exit 1
fi


check() {
	FILE="${BUILD_DIR}/${FLAVOUR}-webapp-${1}-${2}.tar.bz2"
	echo "  ${FILE}:"
	if [ ! -f $FILE ]; then
    echo "  Error: file missing"
    return 1
  fi

	(bzip2 -tv ${FILE} && echo "  Valid bzip2" ) || (echo "  Error: invalid bzip2" && return 1)
}

findAndUnpack() {
  DST=${1}
  APP=${2}

	echo "> Unpacking $APP@${APP_VERSION}"

  PACK="${BUILD_DIR}/${FLAVOUR}-webapp-${APP}-${APP_VERSION}.tar.bz2"

  if [ "master" != "${APP_VERSION}" ]; then
    if [ ! -f "${PACK}" ]; then
      echo " - could not find '${APP_VERSION}', fallback to 'master'"
      PACK="${BUILD_DIR}/${FLAVOUR}-webapp-${APP}-master.tar.bz2"
    fi
  fi

	mkdir -p ${DST}
	tar -xjf "${PACK}" -C "${DST}"
  echo " - unpacked $APP@${APP_VERSION} to ${DST}"
}

# cleanup empty files
find ${BUILD_DIR} -name '*tar.bz2' -size 0 -delete

echo "Available builds:"
find ${BUILD_DIR} -name '*tar.bz2' -exec basename {} \;|sort
echo

for APP in $APPS; do
	echo "Verifying ${APP}@${APP_VERSION}"

  if [ "master" == "${APP_VERSION}" ]; then
    check $APP ${APP_VERSION}
  else
    check $APP ${APP_VERSION} || check $APP "master"
	fi
done;


findAndUnpack "dist/" "one"
for APP in $APPS; do
  findAndUnpack "dist/$APP" "${APP}"
done;
