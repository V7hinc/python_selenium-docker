#!/usr/bin/env python3
# -*- coding:utf-8 -*-
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import time
import sys
import os


BASE_DIR = os.path.dirname(os.path.abspath(__file__))
screenshot_path = os.path.join(BASE_DIR, "screenshot")  # 存放截图的目录
if not os.path.isdir(screenshot_path):
    os.makedirs(screenshot_path)


def web_capture(url, save="capture.png"):
    # 设置chrome浏览器的一些设置
    chrome_options = Options()

    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--headless')  # 开启无界面模式
    chrome_options.add_argument('--disable-gpu')
    # browser = webdriver.Firefox()
    # 使用内核打开浏览器
    browser = webdriver.Chrome(options=chrome_options)

    browser.get(url)  # Load page

    browser.implicitly_wait(2)

    time.sleep(1)

    # 接下来是全屏的关键，用js获取页面的宽高，如果有其他需要用js的部分也可以用这个方法
    width = browser.execute_script("return document.documentElement.scrollWidth")
    height = browser.execute_script("return document.documentElement.scrollHeight")
    # 将浏览器的宽高设置成刚刚获取的宽高
    browser.set_window_size(width, height)

    save_file_path = os.path.join(screenshot_path, save)
    browser.save_screenshot(save_file_path)
    browser.close()


if __name__ == "__main__":
    args = sys.argv
    if len(args) < 2:
        print("缺少网址，如：python3 website_screenshot.py http://www.baidu.com")
    else:
        target_url = args[1]
        print(target_url)
        web_capture(target_url)