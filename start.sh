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
	API_BASEURL_COMPOSE=${API_BASEURL_COMPOSE:-"${API_SCHEME}//compose.api.${API_BASEURL}"}

	tee \
		${BASEDIR}/messaging/config.js \
		${BASEDIR}/auth/config.js \
		${BASEDIR}/admin/config.js \
		${BASEDIR}/compose/config.js \
		> ${BASEDIR}/config.js << EOF
window.CrustSystemAPI = '${API_BASEURL_SYSTEM}'
window.CrustMessagingAPI = '${API_BASEURL_MESSAGING}'
window.CrustComposeAPI = '${API_BASEURL_COMPOSE}'
EOF
}

[[ "$CONFIG_FILE_GEN" -eq "1" ]] && generate

nginx -g "daemon off;"