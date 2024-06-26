#!/bin/bash

# Agentのダウンロード
echo "curl -O https://cdn.zabbix.com/zabbix/binaries/stable/4.4/4.4.10/zabbix_agent-4.4.10-linux-3.0-amd64-static.tar.gz"
curl -O https://cdn.zabbix.com/zabbix/binaries/stable/4.4/4.4.10/zabbix_agent-4.4.10-linux-3.0-amd64-static.tar.gz
echo -e "\n\n"

# 作業用ディレクトリの作成と解凍
if [ ! -d "zabbix_agent-4.4.10" ]; then
  mkdir -p "zabbix_agent-4.4.10"
fi
echo "tar zxvf ./zabbix_agent-4.4.10-linux-3.0-amd64-static.tar.gz -C zabbix_agent-4.4.10"
tar zxvf ./zabbix_agent-4.4.10-linux-3.0-amd64-static.tar.gz -C zabbix_agent-4.4.10
echo -e "\n\n"

# Agentの配置
echo "sudo cp -ia ./zabbix_agent-4.4.10/sbin/zabbix_agentd /usr/sbin/"
sudo cp -ia ./zabbix_agent-4.4.10/sbin/zabbix_agentd /usr/sbin/
echo -e "\n\n"

# Confの配置
if [ ! -d "/etc/zabbix" ]; then
  sudo mkdir -p "/etc/zabbix"
fi
echo "sudo cp -ia ./zabbix_agent-4.4.10/conf/zabbix_agentd.conf /etc/zabbix/"
#rootで起動可能するおまじない
sed -i 's/^# PidFile=\/tmp\/zabbix_agentd.pid$/PidFile=\/run\/zabbix\/zabbix_agentd.pid/' ./zabbix_agent-4.4.10/conf/zabbix_agentd.conf
sed -i 's/^# AllowRoot=0/AllowRoot=1/' ./zabbix_agent-4.4.10/conf/zabbix_agentd.conf
sudo cp -ia ./zabbix_agent-4.4.10/conf/zabbix_agentd.conf /etc/zabbix/
echo -e "\n\n"

# Servicesファイルのダウンロード
echo "curl -O https://raw.githubusercontent.com/nakamuram/Script/main/zabbix-agent.service"
curl -O https://raw.githubusercontent.com/nakamuram/Script/main/zabbix-agent.service
echo -e "\n\n"

# Servicesファイルの配置
echo "sudo cp -ia zabbix-agent.service /etc/systemd/system/"
sudo cp -ia zabbix-agent.service /etc/systemd/system/
echo -e "\n\n"

# デーモンのリロード
sudo systemctl daemon-reload
sudo systemctl restart zabbix-agent

# 以下な感じだとステキかも
# curl -O https://raw.githubusercontent.com/nakamuram/Script/main/zabbix_agent-4.4.10_install.sh && chmod +x ./zabbix_agent-4.4.10_install.sh && ./zabbix_agent-4.4.10_install.sh
