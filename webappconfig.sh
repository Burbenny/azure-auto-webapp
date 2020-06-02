#!/bin/bash

#have the deployment url in variable url
touch url.json
az webapp deployment source config-local-git --name test-1-tf-appservice --resource-group test-1-tf-rg > url.json
url=`jq '.url' url.json`
url="${url%\"}"
url="${url#\"}"


#initialise the local git repo 
echo "enter the git url for deployment:" 
read gitlink
git clone $gitlink tempfolder
cd tempfolder
git remote add azure $url
git push azure master
cd .. 
rm -rf tempfolder/
rm url.json