#!/bin/bash

set -e

#ip link add name br0 type bridge
#sleep 1
#ip link set dev br0 up
#sleep 1
#ip link set enp1s0 master br0
#sleep 1
	#ip address add dev br0 192.168.1.188/24
#ip address add dev br0 10.0.0.127/24
#sleep 5

ip link add name br0 type bridge
sleep .5
ip link set dev br0 up
sleep .5
ip address add 10.0.0.127/24 dev br0
sleep .5
ip route append default via 10.0.0.1 dev br0
sleep .5
ip link set enp1s0 master br0
sleep .5
ip address del 10.0.0.127/24 dev enp1s0
sleep 5

virsh start debian12
