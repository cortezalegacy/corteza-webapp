#!/bin/bash
rm -rf api && mkdir api
php codegen.php System ../../crust/api/system/spec.json api/system.js
php codegen.php CRM ../../crust/api/crm/spec.json api/crm.js
php codegen.php SAM ../../crust/api/sam/spec.json api/sam.js
cp api/*.js ../common/src/plugins/