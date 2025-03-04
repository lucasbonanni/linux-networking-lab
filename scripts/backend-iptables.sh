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

# Allow incoming HTTP traffic from LAN to DMZ web application
$IPT -A INPUT -i enp0s3 -p tcp --dport 8080 -d 192.168.10.35 -j ACCEPT

# Allow established connections
$IPT -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IPT -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Enable NAT
$IPT -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE
$IPT --append FORWARD --in-interface enp0s8 -j ACCEPT
$IPT -t nat -A PREROUTING -i enp0s8 -p tcp --dport 8080 -j DNAT --to-destination 192.168.10.35

# Allow ping
$IPT -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

# Allow Incoming Rsync from Specific IP Address
$IPT -A INPUT -p tcp -s 192.168.10.0/27 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
$IPT -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# SSH
$IPT -A INPUT -p tcp -s 192.168.10.5 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
$IPT -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Block traffic from DMZ to LAN
$IPT -A FORWARD -i enp0s3 -o enp0s8 -j DROP

# Enable IP forwarding
echo "Enabling IP forwarding"
echo 1 > /proc/sys/net/ipv4/ip_forward

$IPTS > /etc/iptables/rules.v4