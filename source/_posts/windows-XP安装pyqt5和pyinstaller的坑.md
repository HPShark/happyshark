---
title: windows XP安装pyqt5和pyinstaller的坑
date: 2019-3-24 14:00:00
tags: [windowsXP, pyqt5]
categories: python
description: 
cover: https://cdn.jsdelivr.net/gh/HPShark/blogimages@master/windowsXP_pyqt/封面.png
---

# xp支持的python和qt版本
- Windows xp 不能运行python3.5及以上版本python。

- Windows xp 不能运行qt5.7及以上版本qt。

- Pyqt5官方预编译二进制文件不能在xp上运行。

- Windows xp 能运行的最高版本的python版本为：python3.4和python2.7

- Windows xp 上能运行的最高版本的qt为qt5.6.3

# 准备安装包

- windows xp镜像（itellyou.cn）要下载vl版本的
- Python 3.4.4 (官网下载安装程序)
- pip (官网下载get-pip.py文件安装)
- PyQt 5.5.1
- pywin32 220 (221和最新的222没有尝试)
- PyInstaller 3.2.1 (pip install pyinstaller==3.2.1)
- pySrial 3.0.1 (pip install pyserial==3.0.1)
- eric6 ：可以安装17.03.1，Eric6的主程序文件是 $python安装文件夹$\Lib\site-packages\eric6\eric6.pyw

注1：如果不手动安装pywin32是无法安装PyInstaller的.

注2：pip install 安装慢的话可以用清华源：https://mirrors.tuna.tsinghua.edu.cn/help/pypi/

注3：相关安装包下载地址：https://www.lanzous.com/b015akode 密码:7zjp

