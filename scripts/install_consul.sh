#!/usr/bin/env bash

# exit if product is not set
if [ ! "$PRODUCT" ] ; then
  echo "this script needs a variable PRODUCT=product"
  exit 1
fi

# get last OSS version if VERSION not set
if [ ! "$VERSION" ] ; then
  VERSION=`curl -sL https://releases.hashicorp.com/${PRODUCT}/index.json | jq -r '.versions[].version' | sort -V | egrep -v 'ent|beta|rc|alpha' | tail -1`
fi

which ${PRODUCT} || {
  cd /usr/local/bin
  wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_amd64.zip
  unzip ${PRODUCT}_${VERSION}_linux_amd64.zip
}

# Set up config directory
mkdir -p /etc/consul.d/
chown -R consul /etc/consul.d

# Set up systemd consul service
cat <<EOF > /etc/systemd/system/consul.service
[Unit]
Description="HashiCorp Consul - A service mesh solution"
Documentation=https://www.consul.io/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/consul.d/consul.hcl

[Service]
User=consul
Group=consul
ExecStart=/usr/local/bin/consul agent -config-dir=/etc/consul.d/
ExecReload=/usr/local/bin/consul reload
KillMode=process
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF