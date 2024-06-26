#!/bin/bash

# Agentのダウンロード
echo "curl -O https://cdn.zabbix.com/zabbix/binaries/stable/4.4/4.4.10/zabbix_agent-4.4.10-linux-3.0-amd64-static.tar.gz"
curl -O https://cdn.zabbix.com/zabbix/binaries/stable/4.4/4.4.10/zabbix_agent-4.4.10-linux-3.0-amd64-static.tar.gz
echo -e "\n\n\n"

# 作業用ディレクトリの作成と解凍
if [ ! -d "zabbix_agent-4.4.10" ]; then
  mkdir -p "zabbix_agent-4.4.10"
fi
echo "tar zxvf ./zabbix_agent-4.4.10-linux-3.0-amd64-static.tar.gz -C zabbix_agent-4.4.10"
tar zxvf ./zabbix_agent-4.4.10-linux-3.0-amd64-static.tar.gz -C zabbix_agent-4.4.10
echo -e "\n\n\n"

# Agentの配置
echo "sudo cp -ia ./zabbix_agent-4.4.10/sbin/zabbix_agentd /usr/sbin/"
sudo cp -ia ./zabbix_agent-4.4.10/sbin/zabbix_agentd /usr/sbin/
echo -e "\n\n\n"

# Confの配置
if [ ! -d "/etc/zabbix" ]; then
  sudo mkdir -p "/etc/zabbix"
fi
echo "sudo cp -ia ./zabbix_agent-4.4.10/conf/zabbix_agentd.conf /etc/zabbix/"
sudo cp -ia ./zabbix_agent-4.4.10/conf/zabbix_agentd.conf /etc/zabbix/
echo -e "\n\n\n"

#Servicesファイルのダウンロードと配置
echo "curl -O https://raw.githubusercontent.com/nakamuram/Script/main/zabbix-agent.service"
curl -O https://raw.githubusercontent.com/nakamuram/Script/main/zabbix-agent.service
echo -e "\n\n\n"

#Servicesファイルの配置
echo "sudo cp -ia zabbix-agent.service /etc/systemd/system/"
sudo cp -ia zabbix-agent.service /etc/systemd/system/
echo -e "\n\n\n"
