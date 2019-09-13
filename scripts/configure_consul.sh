#!/usr/bin/env bash

# Populate other node's IPs to retry_join
cat <<EOF >/etc/consul.d/retry_join.json
{
  "retry_join": $RETRYIPS
}
EOF
echo "{ \"retry_join\": $RETRYIPS }" > /etc/consul.d/retry_join.json

if [ "$SERVER" == "true" ]; then
    # setup server settings
    cat <<EOF >/etc/consul.d/server.json
{
  "server": true,
  "bootstrap_expect": $BOOTSTRAP
}
EOF
else
    # setup client settings
    cat <<EOF >/etc/consul.d/client.json
{
  "server": false
}
EOF
fi
# Set up server settings