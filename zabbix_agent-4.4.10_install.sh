#!/bin/bash

echo "ZabbixAgentのダウンロード"
curl -O https://cdn.zabbix.com/zabbix/binaries/stable/4.4/4.4.10/zabbix_agent-4.4.10-linux-3.0-amd64-static.tar.gz
echo -e "\n\n"

echo "作業用ディレクトリの作成と解凍"
if [ ! -d "zabbix_agent-4.4.10" ]; then
  mkdir -p "zabbix_agent-4.4.10"
fi
tar zxvf ./zabbix_agent-4.4.10-linux-3.0-amd64-static.tar.gz -C zabbix_agent-4.4.10
echo -e "\n\n"

echo "ZabbixAgentの配置"
sudo cp -ia ./zabbix_agent-4.4.10/sbin/zabbix_agentd /usr/sbin/
echo -e "\n\n"

echo "ZabbixAgent confの配置"
if [ ! -d "/etc/zabbix" ]; then
  sudo mkdir -p "/etc/zabbix"
fi
#rootで起動可能にするおまじない
sed -i 's/^# AllowRoot=0/AllowRoot=1/' ./zabbix_agent-4.4.10/conf/zabbix_agentd.conf
sudo cp -ia ./zabbix_agent-4.4.10/conf/zabbix_agentd.conf /etc/zabbix/
echo -e "\n\n"

echo "Servicesファイルのダウンロード"
curl -O https://raw.githubusercontent.com/nakamuram/Script/main/zabbix-agent.service
echo -e "\n\n"

echo "Servicesファイルの配置"
sudo cp -ia zabbix-agent.service /etc/systemd/system/
echo -e "\n\n"

echo "サービスを有効にする"
sudo systemctl enable zabbix-agent.service
echo "デーモンのリロード（設定の再読み込み）"
sudo systemctl daemon-reload
echo "サービスの再起動"
sudo systemctl restart zabbix-agent
echo -e "\n\n"

echo "サービスの起動確認"
sudo systemctl status zabbix-agent

# 以下な感じだとステキかも
# curl -O https://raw.githubusercontent.com/nakamuram/Script/main/zabbix_agent-4.4.10_install.sh && chmod +x ./zabbix_agent-4.4.10_install.sh && ./zabbix_agent-4.4.10_install.sh
