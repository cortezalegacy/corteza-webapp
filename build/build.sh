#!/usr/bin/env bash

set -eu

BRANCH=${1}
shift
APPS="webapp-chrome webapp-crm webapp-messaging webapp-admin"

echo "################################################################################"
echo "Cloning repositories (branch: ${BRANCH})..."
for APP in ${APPS}; do
    time git clone --progress --verbose --depth=1 --single-branch --branch ${BRANCH} https://github.com/crusttech/${APP}.git /build/${APP}
done

echo "################################################################################"
echo "Prebuild scripts..."
for APP in ${APPS}; do
    cd /build/${APP}
    APP_PREBUILD_SCRIPT="/build/${APP}-prebuild.sh"
    if [[ -f "${APP_PREBUILD_SCRIPT}" ]]; then
        echo "Running ${APP_PREBUILD_SCRIPT}"
        source "${APP_PREBUILD_SCRIPT}";
    fi;
done

echo "################################################################################"
echo "Dependencies & building..."
for APP in ${APPS}; do
    echo "================================================================================"
    echo "${APP}"
    cd /build/${APP}
    echo "> install"
    time yarn install --frozen-lockfile
    echo "> build"
    time yarn build
    echo "> cleanup"
    rm -rf node_modules
done

echo "################################################################################"
echo "Cleanup..."
for APP in ${APPS}; do
    mkdir -p /crust/${APP}
    mv /build/${APP}/dist/* /crust/${APP}/
done

echo "################################################################################"
echo "Place apps where they need to be..."
mv /crust/webapp-chrome /crust/webapp
mv /crust/webapp-messaging /crust/webapp/messaging
mv /crust/webapp-crm /crust/webapp/crm
mv /crust/webapp-admin /crust/webapp/admin

echo "Done."
