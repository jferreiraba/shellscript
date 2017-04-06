#!/bin/bash
#
# Program Name: net.sh
# Author: JohnJohn
#
# Description: Shellscript facilita a configuração do WIFI AD-HOC no linux.
#

#
# Variaveis globais.
#
INTERFACE_WLAN=""
SSID=""
CHANNEL=""
PASSWORD=""
IPTABLES="/sbin/iptables"
IP=""
MASK=""

#
# Não modifique nenhuma linha abaixo.
#
echo -n "Ajustando o firewall..."
$IPTABLES -t nat -F
$IPTABLES -t nat -A POSTROUTING -o eth0 -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward
echo -e "\033[0;32m OK \033[0m "

echo -n "Desligando a interface wlan0... "
ifconfig $INTERFACE_WLAN down
echo -e "\033[0;32m OK \033[0m "

echo -n "Configurando ad-hoc... "
iwconfig $INTERFACE_WLAN essid $SSID mode Ad-Hoc channel $CHANNEL key restricted $PASSWORD
echo -e "\033[0;32m OK \033[0m "

echo -n "Subindo a interface wlan0... "
ifconfig $INTERFACE_WLAN $IP netmask $MASK up
echo -e "\033[0;32m OK \033[0m "

echo -n "Verificando o servidor DHCP... "
killall dhcpd 2> /dev/null
dhcpd $INTERFACE_WLAN 2> /dev/null
echo -e "\033[0;32m OK \033[0m "
echo "Rede ad-hoc configurada..."

