#!/bin/sh
# cafwfrontend - eth1: dhcp  - eth2: 192.168.10.34/27
# in <--> out http:80/443

# Flush de reglas
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

# Se establecen politicas por defecto.
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

## Filtros

# Acceso local desde la red.
iptables -A INPUT -s 192.168.10.0/24 -i eth2 -j ACCEPT

# Enmascaramiento de la red local y la DMZ
iptables -t nat -A POSTROUTING -s 192.168.10.0/24 -o eth1 -j MASQUERADE # Está bien la red 192.168.10.0? o debería ser la 192.168.10.32/27 ?

# Permitimos el acceso desde el exterior a los puertos 80 y 443 de DMZ
iptables -A FORWARD -d 192.168.10.35 -p tcp -dport 80 -j ACCEPT
iptables -A FORWARD -d 192.168.10.35 -p tcp -dport 443 -j ACEPT
iptables -A FORWARD -d 192.168.10.32/27 -j DROP  # bloqueamos otros accesos

# Cierro el acceso al firewall desde el servidor. 192.168.10.35/27
iptables -A INPUT -s 192.168.10.35 -i eth2 -j DROP

# Cierro un rango de ip no utilizado.
iptables -A INPUT -s 0.0.0.0/0 -p tcp -dport 1:1024 -j DROP
iptables -A INPUT -s 0.0.0.0/0 -p udp -dport 1:1024 -j DROP


# Para denegar las respuestas a ping.
# sudo iptables -I INPUT -p icmp --icmp-type 8 -j DROP

# iptables -L -n -v --line-numbers