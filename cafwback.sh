#!/bin/sh
IPT="/usr/sbin/iptables"
IPTS="/usr/sbin/iptables-save"
IPTR="/usr/sbin/iptables-restore"

# Define interface and network variables
INET_IFACE="enp0s3"
INET_ADDRESS="192.168.10.33"
LOCAL_IFACE="enp0s8"
LOCAL_IP="192.168.10.1"
LOCAL_NET="192.168.10.0/27"
LOCAL_BCAST="192.168.10.31"
LO_IFACE="lo"
LO_IP="127.0.0.1"

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
# $IPT -P INPUT DROP
# $IPT -P OUTPUT DROP
# $IPT -P FORWARD DROP

$IPT -P INPUT DROP
$IPT -P FORWARD DROP
$IPT -P OUTPUT ACCEPT


# Allow loopback traffic
$IPT -A INPUT -i $LO_IFACE -j ACCEPT
$IPT -A OUTPUT -o $LO_IFACE -j ACCEPT

# Enable IP forwarding
echo "Enabling IP forwarding"
echo 1 > /proc/sys/net/ipv4/ip_forward

# Allow established connections
$IPT -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IPT -A FORWARD -i $INET_IFACE -p tcp --dport 8080 -d 192.168.10.35 -j ACCEPT
# Enable NAT for internal network
# $IPT -t nat -A POSTROUTING -s $LOCAL_NET -o $INET_IFACE -j MASQUERADE

$IPT -A FORWARD -i $LOCAL_IFACE -o $INET_IFACE -j ACCEPT

# Block access from DMZ to the firewall
# $IPT -A INPUT -s $LOCAL_NET -i $LOCAL_IFACE -j DROP

# Close ports below 1024 for external access
$IPT -A INPUT -p tcp --dport 1:1024 -j DROP
$IPT -A INPUT -p udp --dport 1:1024 -j DROP

# Save the rules
mkdir -p /etc/iptables/
$IPTS > /etc/iptables/rules.v4

echo "Firewall configuration applied successfully!"
