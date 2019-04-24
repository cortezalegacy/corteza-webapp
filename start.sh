#!/usr/bin/env sh

set -eu

CONFIG_FILE_GEN=${CONFIG_FILE_GEN:-"1"}


function generate {
	API_BASEURL=${API_BASEURL:-"${VIRTUAL_HOST}"}
	API_BASEURL=${API_BASEURL:-"local.crust.tech"}
	BASEDIR=${BASEDIR:-"/crust/webapp"}

	API_SCHEME=${API_SCHEME:-""}
	API_BASEURL_SYSTEM=${API_BASEURL_SYSTEM:-"${API_SCHEME}//system.api.${API_BASEURL}"}
	API_BASEURL_MESSAGING=${API_BASEURL_MESSAGING:-"${API_SCHEME}//messaging.api.${API_BASEURL}"}
	API_BASEURL_CRM=${API_BASEURL_CRM:-"${API_SCHEME}//crm.api.${API_BASEURL}"}

	tee \
		${BASEDIR}/messaging/config.js \
		${BASEDIR}/auth/config.js \
		${BASEDIR}/admin/config.js \
		${BASEDIR}/crm/config.js \
		> ${BASEDIR}/config.js << EOF
window.CrustSystemAPI = '${API_BASEURL_SYSTEM}'
window.CrustMessagingAPI = '${API_BASEURL_MESSAGING}'
window.CrustCrmAPI = '${API_BASEURL_CRM}'
EOF
}

[[ "$CONFIG_FILE_GEN" -eq "1" ]] && generate

nginx -g "daemon off;"