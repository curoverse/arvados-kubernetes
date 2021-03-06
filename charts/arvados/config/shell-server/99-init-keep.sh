#!/bin/bash
# Copyright (C) The Arvados Authors. All rights reserved.
#
# SPDX-License-Identifier: Apache-2.0

set -e
export HOME="/root"
export ARVADOS_API_TOKEN={{ .Values.superUserSecret }}
export ARVADOS_API_HOST={{ .Values.externalIP }}:444
export ARVADOS_API_HOST_INSECURE="true"
arv keep_service create --keep-service "$(cat <<EOF
{
 "service_host":"arvados-keep-store-0.arvados-keep-store",
 "service_port":25107,
 "service_ssl_flag":false,
 "service_type":"disk"
}
EOF
)"

arv keep_service create --keep-service "$(cat <<EOF
{
 "service_host":"arvados-keep-store-1.arvados-keep-store",
 "service_port":25107,
 "service_ssl_flag":false,
 "service_type":"disk"
}
EOF
)"

arv keep_service create --keep-service "$(cat <<EOF
{
 "service_host":"{{ .Values.externalIP }}",
 "service_port":25107,
 "service_ssl_flag":true,
 "service_type":"proxy"
}
EOF
)"
