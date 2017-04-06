#!/bin/bash

#
# Program name: net-adhoc-client.sh
# Author: JohnJohn
#

#
# Variaveis globais.
#

IWLAN=""
SSID=""
CHANNEL=""
PASSWORD=""
IP=""
MASK=""
GATEWAY=""
DNS1="8.8.8.8"

#
# Não modifique abaixo.
#


echo -n "Desativando a interface $IWLAN..."
ifconfig $IWLAN down
echo -e "\033[0;32m OK \033[0m "

echo -n "Conectando a rede Ad-Hoc..."
iwconfig $IWLAN essid $SSID mode Ad-Hoc channel $CHANNEL key restricted $PASSWORD
echo -e "\033[0;32m OK \033[0m "

echo -n "Ativando a interface $IWLAN..."
ifconfig $IWLAN $IP netmask $MASK up
echo -e "\033[0;32m OK \033[0m "

echo -n "Configurando rota padrao..."
route add default gw $GATEWAY
echo -e "\033[0;32m OK \033[0m "

echo -n "Configurando o DNS..."
echo $DNS1 >> /etc/resolv.conf
echo -e "\033[0;32m OK \033[0m "