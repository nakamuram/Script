#!/bin/bash

# スクリプトのバージョン
VERSION="1.0.0"

# Zabbix Agentの設定ファイル
CONF_File="/usr/local/etc/zabbix_agentd.conf"

# Zabbix Agentの起動コマンド
START_CMD="/usr/local/sbin/zabbix_agentd -c $CONF_File"

# Zabbix AgentのプロセッスIDを取得するコマンド
# PID_CMD="ps -ef | grep zabbix_agentd | grep -v grep | awk '{print \$2}'"

# ヘルプメッセージ
function usage() {
  echo "Usage: $0 [start|stop|status]"
  echo "  start: Zabbix Agentを起動します。"
  echo "  stop: Zabbix Agentを停止します。"
  echo "  status: Zabbix Agentの状態を表示します。"
  echo "  version: スクリプトのバージョンを表示します。"
  exit 1
}

# バージョン情報の表示
function version() {
  echo "Zabbix Agent Control Script v$VERSION"
  exit 0
}

# Zabbix Agentの起動
function start() {
  if [ -n "$(pgrep zabbix_agentd)" ]; then
    echo "Zabbix Agentはすでに起動しています。"
    exit 1
  fi

  echo "Zabbix Agentを起動しています..."
  $START_CMD &
    sleep 3

  # 起動成功を確認
  if [ -n "$(pgrep zabbix_agentd)" ]; then
    echo "Zabbix Agentの起動に成功しました。"
  else
    echo "Zabbix Agentの起動に失敗しました。"
    exit 1
  fi
}

# Zabbix Agentの停止
function stop() {
  if [ -z "$(pgrep zabbix_agentd)" ]; then
    echo "Zabbix Agentはすでに停止しています。"
    exit 1
  fi

  echo "Zabbix Agentを停止しています..."
  PID=$(pgrep zabbix_agentd)
  kill $PID

  # 停止成功を確認
  if [ -z "$(pgrep zabbix_agentd)" ]; then
    echo "Zabbix Agentの停止に成功しました。"
  else
    echo "Zabbix Agentの停止に失敗しました。"
    exit 1
  fi
}

# Zabbix Agentの状態確認
function status() {
  if [ -n "$(pgrep zabbix_agentd)" ]; then
    echo "Zabbix Agentは起動しています。"
    echo
    ps -ef | grep -v grep | grep zabbix_agentd
  else
    echo "Zabbix Agentは停止しています。"
  fi
}

# 処理の分岐
case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    status
    ;;
  version)
    version
    ;;
  *)
    usage
    ;;
esac

