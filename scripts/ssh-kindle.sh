#!/bin/bash

KINDLE_MAC="98:CC:F3:FA:2B:28"
KINDLE_IP=$(arp -a | grep -i "$KINDLE_MAC" | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}" | head -1)

if [ -z "$KINDLE_IP" ]; then
  echo "Kindle não encontrado na rede. Fazendo scan..."
  nmap -p 2222 -sn 192.168.1.0/24 >/dev/null
  KINDLE_IP=$(arp -a | grep -i "$KINDLE_MAC" | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}" | head -1)
fi

if [ -z "$KINDLE_IP" ]; then
  echo "Erro: Kindle não encontrado!"
  exit 1
fi

echo "Conectando ao Kindle em $KINDLE_IP..."
ssh -p 2222 root@$KINDLE_IP
