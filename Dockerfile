FROM python:3.9.9-slim-buster
MAINTAINER <V7hinc>

ENV TIME_ZONE=Asia/Shanghai

COPY 163sources.list /etc/apt/sources.list

# 安装必要组件
RUN set -x;\
apt-get update;\
apt-get install procps -y;

# 修改时区
RUN set -x;\
ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone


COPY install_chrome_driver.sh /app/pyproject/
WORKDIR /app/pyproject

RUN set -x;\
# 安装chromedriver
bash install_chrome_driver.sh;\
rm -f install_chrome_driver.sh

# 安装字体，否则截图会中文乱码
COPY FZKTJW.TTF /usr/share/fonts

COPY src/requirements.txt /app/pyproject/
RUN set -x;\
# 安装依赖库
pip3 install -r requirements.txt -i https://pypi.douban.com/simple;

COPY src /app/pyproject/

ENTRYPOINT ["python3", "website_screenshot.py"]
CMD ["http://www.baidu.com"]

