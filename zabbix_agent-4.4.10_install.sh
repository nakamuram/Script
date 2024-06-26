#!/bin/bash

# Agentのダウンロード
curl -O https://cdn.zabbix.com/zabbix/binaries/stable/4.4/4.4.10/zabbix_agent-4.4.10-linux-3.0-amd64-static.tar.gz

# 作業用ディレクトリの作成と解凍
if [ ! -d "zabbix_agent-4.4.10" ]; then
  mkdir -p "zabbix_agent-4.4.10"
fi
#mkdir zabbix_agent-4.4.10 && tar zxvf ./zabbix_agent-4.4.10-linux-3.0-amd64-static.tar.gz -C zabbix_agent-4.4.10
tar zxvf ./zabbix_agent-4.4.10-linux-3.0-amd64-static.tar.gz -C zabbix_agent-4.4.10

# Agentの配置
sudo cp ./zabbix_agent-4.4.10/sbin/zabbix_agentd /usr/sbin/

# Confの配置
if [ ! -d "/etc/zabbix" ]; then
  sudo mkdir -p "/etc/zabbix"
fi
sudo cp ./zabbix_agent-4.4.10/conf/zabbix_agentd.conf /etc/zabbix/



