#!/bin/bash

set -ev
git clone https://${GH_REF} .deploy_git
cd .deploy_git
git checkout master
cd ../
mv .deploy_git/.git/ ./public/
cd ./public
git config user.name "HPShark" # 修改name
git config user.email "www.yaoyuchao@qq.com" # 修改email
# add commit timestamp
git add .
git commit -m "Travis CI Auto Builder at `date +"%Y-%m-%d %H:%M"`"
git push --force --quiet "https://${Travis_Token}@${GH_REF}" master:master