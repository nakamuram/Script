#!/bin/bash

# Agentのダウンロード
curl -O https://cdn.zabbix.com/zabbix/binaries/stable/4.4/4.4.10/zabbix_agent-4.4.10-linux-3.0-amd64-static.tar.gz

# 作業用ディレクトリの作成と解凍
mkdir zabbix_agent-4.4.10 && tar zxvf ./zabbix_agent-4.4.10-linux-3.0-amd64-static.tar.gz -C zabbix_agent-4.4.10


