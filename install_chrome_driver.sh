#!/bin/bash

BASEDIR=`dirname $0`
BASEDIR=`(cd "$BASEDIR"; pwd)`

# centos安装chrome
centosInstall(){
echo "开始安装google-chrome"
cat>/etc/yum.repos.d/google-chrome.repo<<EOF
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
sed -i 's/basearch/$basearch/g' /etc/yum.repos.d/google-chrome.repo
yum -y install google-chrome-stable --nogpgcheck;
}

# debian或ubuntu安装chrome
debianInstall(){
echo "开始安装google-chrome"
curl -sSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
apt --fix-broken install -y
rm -f google-chrome-stable_current_amd64.deb
}

install(){
# 判断linux操作系统
os=$(cat /etc/issue|awk 'NR==1 {print $1}')
if [ "$os" = "\S" ];then
    echo "CentOS"
    yum install -y curl unzip
    centosInstall
else
    echo $os
    apt update
    apt install -y curl unzip
    debianInstall
fi

}


# 判断是否安装了google-chrome
if command -v google-chrome &> /dev/null
then
    echo "google-chrome exist"
else
    install
fi


# 查看chrome浏览器版本
google-chrome --version

# 安装 chromedriver
if command -v chromedriver &> /dev/null
then
    echo "chromedriver exist"
else
    ver=$(google-chrome --version|awk 'NR==1 {print $3}'| awk -F "." '{print $1"."$2"."$3}')
    latest_release=$(curl -sSL "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$ver")
    downurl="https://chromedriver.storage.googleapis.com/$latest_release/chromedriver_linux64.zip"
    curl -sSL $downurl -o chromedriver_linux64.zip
    unzip chromedriver_linux64.zip -d /usr/bin/
    rm -f chromedriver_linux64.zip
fi

# 查看chromedriver浏览器版本
chromedriver --version

echo "安装完成"

