#!/bin/bash
set -e -o pipefail

net_dev=$(ip a | grep -E '^[2-9]: b' | sed -E 's/^[2-9]: (b[^:]+):.+/\1/g')
ipaddr=$(ip a show $net_dev | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1)
gate=$(ip route | grep default | sed -E 's/default via ([^ ]+) .+/\1/g')


read -p "Gateway (${gate}): " gateway
if [ ! "$gateway" ]; then
  gateway="$gate"
fi

read -p "IP Address (${ipaddr}): " ipv4name
if [ ! "$ipv4name" ]; then
  ipv4name="$ipaddr"
fi

echo "Gateway: $gateway"
echo "IPV4: $ipv4name"

