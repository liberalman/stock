#!/bin/sh

source /etc/profile

# add crontab
exist=`crontab -l|grep stock`
if [ -z "${exist}" ];then
  crontab -l > /tmp/crontab.bak
  echo '0 23 * 1,2,3,4,5 * /data/stock/dostock.sh > /var/log/dostock.log 2>&1 &' >> /tmp/crontab.bak
  crontab /tmp/crontab.bak
  rm -f /tmp/crontab.bak
fi

# dostock
pushd /data/stock/tiger_list

python3 fetch.py
python3 analysis.py

token=""
day=`date "+\%Y-\%m-\%d"`
content=`cat ../tmp/沪深龙虎榜统计_${day}.md`
curl -d "text=龙虎榜统计&desp=${content}" \
    https://sc.ftqq.com/${token}.send

popd

