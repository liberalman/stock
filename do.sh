#!/bin/sh

# 0 23 * 1,2,3,4,5 *  /data/stock/do.sh > /var/log/stock.log 2>&1 &
source /etc/profile

pushd /data/stock/tiger_list

python3 fetch.py
python3 analysis.py

content=`cat ../tmp/沪深龙虎榜统计_*.md`
curl -d "text=龙虎榜统计&desp=${content}" \
    https://sc.ftqq.com/SCU46037Tfbc1e16cfe0dcff0fca6a416ff5644fa5c8347a9281db.send

popd

