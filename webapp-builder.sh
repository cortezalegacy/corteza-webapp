#!/usr/bin/env bash

set -eu

BRANCH=${1}
shift
APPS="webapp webapp-crm webapp-messaging"

echo "################################################################################"
echo "Unpacking..."
for APP in ${APPS}; do
    unzip -q /build/${APP}.zip -d /build/
done


echo "################################################################################"
echo "Prebuild scripts..."
for APP in ${APPS}; do
    cd /build/${APP}-${BRANCH}
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
    cd /build/${APP}-${BRANCH}
    yarn
    yarn build
done

echo "################################################################################"
echo "Cleanup..."
for APP in ${APPS}; do
    mkdir -p /crust/${APP}
    mv /build/${APP}-${BRANCH}/dist/* /crust/${APP}/
    rm -rf /build/${APP}.zip /build/${APP}-${BRANCH}
done

mv /crust/webapp-messaging /crust/webapp/messaging
mv /crust/webapp-crm /crust/webapp/crm