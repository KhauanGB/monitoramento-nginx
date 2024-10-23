#!/bin/bash

DATA=$(date "+%Y-%m-%d %H:%M:%S")

if systemctl is-active --quiet nginx; then
	echo "$DATA Nginx ONLINE - O serviço está rodando corretamente" > /home/khauan/nginx_online.txt
else
	echo "$DATA Nginx OFFLINE - O serviço não está rodando corretamente" > /home/khauan/nginx_offline.txt
fi
