---
title: travis-ci在Node.js v14.0下自动构建hexo报错
tags: [hexo, travis CI]
categories: 博客
description: 
cover: https://cdn.jsdelivr.net/gh/HPShark/blogimages@master/node14bug/编译错误.png
---

{% meting "41500546" "netease" "song" %}

---

> 参考https://vensing.com/a-bug-in-nodejs-v14/

# 报错情况

```shell
1.27s$ hexo clean
(node:5971) Warning: Accessing non-existent property 'lineno' of module exports inside circular dependency
(Use `node --trace-warnings ...` to show where the warning was created)
(node:5971) Warning: Accessing non-existent property 'column' of module exports inside circular dependency
(node:5971) Warning: Accessing non-existent property 'filename' of module exports inside circular dependency
(node:5971) Warning: Accessing non-existent property 'lineno' of module exports inside circular dependency
(node:5971) Warning: Accessing non-existent property 'column' of module exports inside circular dependency
(node:5971) Warning: Accessing non-existent property 'filename' of module exports inside circular dependency
322The command "hexo clean" exited with 0.
6.83s$ hexo g
(node:5991) Warning: Accessing non-existent property 'lineno' of module exports inside circular dependency
(Use `node --trace-warnings ...` to show where the warning was created)
(node:5991) Warning: Accessing non-existent property 'column' of module exports inside circular dependency
(node:5991) Warning: Accessing non-existent property 'filename' of module exports inside circular dependency
(node:5991) Warning: Accessing non-existent property 'lineno' of module exports inside circular dependency
(node:5991) Warning: Accessing non-existent property 'column' of module exports inside circular dependency
(node:5991) Warning: Accessing non-existent property 'filename' of module exports inside circular dependency
INFO  Start processing
INFO  Files loaded in 3.93 s
(node:5991) Warning: Accessing non-existent property 'lineno' of module exports inside circular dependency
(node:5991) Warning: Accessing non-existent property 'column' of module exports inside circular dependency
(node:5991) Warning: Accessing non-existent property 'filename' of module exports inside circular dependency
(node:5991) Warning: Accessing non-existent property 'lineno' of module exports inside circular dependency
(node:5991) Warning: Accessing non-existent property 'column' of module exports inside circular dependency
(node:5991) Warning: Accessing non-existent property 'filename' of module exports inside circular dependency
```

# 解决办法

在travis.yml里面的Node.js版本那里把**stable**改成指定版本号就行，错误已经提交至hexo项目的issue，估计过一段时间就能修复

# 附travis.yml中的language用法

```yaml
language: node_js
node_js:
  - 7
```

其中版本号可填如下内容：

- `node` latest stable Node.js release

- `lts/*` latest LTS Node.js release

- `14` latest 14.x release

- `13` latest 13.x release

- `12` latest 12.x release

- `11` latest 11.x release

- `10` latest 10.x release

> 参考自https://docs.travis-ci.com/user/languages/javascript-with-nodejs/

# 吐槽

有点想换GitHub Actions了...