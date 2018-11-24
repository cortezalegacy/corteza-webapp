#!/bin/bash
rm -rf api && mkdir api
php codegen.php System ../../crust/system/docs/src/spec.json api/system.js
php codegen.php CRM ../../crust/crm/docs/src/spec.json api/crm.js
php codegen.php SAM ../../crust/sam/docs/src/spec.json api/sam.js
cp api/*.js ../common/src/plugins/