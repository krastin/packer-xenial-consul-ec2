#!/usr/bin/env bash

# Populate other node's IPs to retry_join
echo "{ \"retry_join\": $RETRYIPS }" > /etc/consul.d/retry_join.json

# Set up server settings
echo "" > /etc/consul.d/server.json
echo "{ \"server\": $SERVER }" > /etc/consul.d/server.json
echo "{ \"bootstrap_expect\": $BOOTSTRAP }" > /etc/consul.d/server.json
