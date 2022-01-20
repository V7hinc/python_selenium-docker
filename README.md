# python_selenium
## 实现一个简单的截图功能website_screenshot

主要目的是为了构建一个chrome环境，方便selenium爬虫使用

docker构建
```
docker build -t ghcr.io/v7hinc/python_selenium:latest .
```
docker容器启动
```
docker run --rm -v `pwd`:/app/pyproject/screenshot -it ghcr.io/v7hinc/python_selenium:latest http://www.baidu.com
```
如果想要python直接运行，使用前需安装好google-chrome和对应版本的chromedriver，并将chromedriver设置到环境变量PATH。否则无法使用
手动启动命令
```
python3 website_screenshot.py http://www.baidu.com
```