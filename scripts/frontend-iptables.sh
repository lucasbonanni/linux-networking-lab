#!/bin/bash

# Variables
LO_IP="127.0.0.1"
LO_IFACE="lo"
INET_IFACE="enp0s3"

# iptables path
IPT="/usr/sbin/iptables"
IPTS="/usr/sbin/iptables-save"
IPTR="/usr/sbin/iptables-restore"

# Flush existing rules and chains
echo "Flushing Tables..."
$IPT -F
$IPT -t nat -F
$IPT -t mangle -F
$IPT -X
$IPT -t nat -X
$IPT -t mangle -X

# Set default policies
echo "Setting Default Policies..."
$IPT -P INPUT DROP
$IPT -P FORWARD DROP
$IPT -P OUTPUT ACCEPT

# Allow loopback traffic
$IPT -A INPUT -i $LO_IFACE -j ACCEPT
$IPT -A OUTPUT -o $LO_IFACE -j ACCEPT

# Allow incoming HTTP traffic for web application
$IPT -A INPUT -i enp0s3 -p tcp --dport 8080 -j ACCEPT

# Allow established connections
$IPT -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IPT -A FORWARD -i enp0s3 -o enp0s8 -p tcp --syn --dport 8080 -m conntrack --ctstate NEW -j ACCEPT
$IPT -A FORWARD -i enp0s3 -o enp0s8 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IPT -A FORWARD -i enp0s8 -o enp0s3 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Allow outgoing traffic
$IPT -A OUTPUT -j ACCEPT

# Enable NAT
$IPT -t nat --append POSTROUTING --out-interface enp0s3 -j MASQUERADE
$IPT --append FORWARD --in-interface enp0s8 -j ACCEPT
$IPT -t nat -A PREROUTING -i enp0s3 -p tcp --dport 8080 -j DNAT --to-destination 192.168.10.35

# Allow ping
$IPT -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

# Enable IP forwarding
echo "Enabling IP forwarding"
echo 1 > /proc/sys/net/ipv4/ip_forward

$IPTS > /etc/iptables/rules.v4