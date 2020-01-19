---
title: hexo博客上线
date: 2019-12-26 14:00:00
tags: [hexo, travis CI, serverless, 语雀]
categories: 博客
---
> 博客又双叒叕上线了，这次使用的是hexo + Github Pages + travis CI + 语雀 + serverless + onedrive图床，部署完成之后可以直接在语雀上编辑文章然后自动发布到博客，云端写作不是梦hhh 



# 部署

> 部署部分是按照博客https://www.simon96.online/2018/10/12/hexo-tutorial/ 配置的，仅做备份之用以便日后博客迁移可以照着这篇文文章重新恢复(ಥ _ ಥ)

本地环境：windows Linux Ubuntu 18.04

## （可选）配置git

首先我得重新在git设置一下身份的名字和邮箱（因为当初都忘了设置啥了，因为遇到坑了）进入到需要提交的文件夹底下（因为直接打开git Bash，在没有路径的情况下，根本没！法！改！刚使用git时遇到的坑。。。）

```
git config --global user.name "yourname"
git config --global user.email“your@email.com"
```

注：yourname是你要设置的名字，your@email是你要设置的邮箱。

## 安装 Node.js和npm

```
sudo apt-get update
sudo apt-get install nodejs
sudo apt-get install npm
```

如果报错,请更改软件源--清华大学开源软件源,并更新

注：查看nodejs和npm版本号

```
nodejs -v
npm -v
```

可以正常打印版本号说明,安装成功

## 安装 Hexo

1. 创建博客所在目录

   ```
   mkdir hexo 
   ```

2. 创建目录

   ```
   mkdir hexo
   ```

3. 切换目录

    ``` 
    cd hexo
    ```

4. 全局安装 Hexo，需要最高权限，记得输入root密码

    ``` 
    sudo npm install -g hexo-cli
    ```

5. 初始化 Hexo

    ```
    hexo init
    ```

	注：如果报错执行代码,不报错忽略

    ```
    sudo npm config set user 0
    sudo npm config set unsafe-perm true
    sudo npm install -g hexo-cli
    ```

## 安装插件

1. 如果安装慢就安装proxychains，并且定义alias npm='proxychains4 npm'

2. 如果要永久定义（重启不失效的话就编辑：

    ```
    vim ~/.bashrc
    ```
    
      并且在末尾添加以下代码并定义 alias
    
    ```
    alias npm='proxychains4 npm'
    ```
    
3. 配置完代理后就可以安装npm插件了

    ```
      npm install hexo-generator-index --save
      npm install hexo-generator-archive --save
      npm install hexo-generator-category --save
      npm install hexo-generator-tag --save
      npm install hexo-server --save
      npm install hexo-deployer-git --save
      npm install hexo-deployer-heroku --save
      npm install hexo-deployer-rsync --save
      npm install hexo-deployer-openshift --save
      npm install hexo-renderer-marked --save
      npm install hexo-renderer-stylus --save
      npm install hexo-generator-feed --save
      npm install hexo-generator-sitemap --save
    ```

## 测试安装成功

```
hexo g && hexo server
```

![本地部署成功](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/部署成功.png)



# 同步到githubpages

## 方案一：GithubPages

1. 创建[Github](https://github.com/)账号

2. 创建仓库， 仓库名为：<Github账号名称>.github.io

3. 将本地Hexo博客推送到GithubPages

   - 安装hexo-deployer-git插件。在命令行（即Git Bash）运行以下命令即可：

     ```
     $ npm install hexo-deployer-git --save
     ```

   - 添加SSH key。

     创建一个 SSH key 。在命令行（即Git Bash）输入以下命令，     回车三下即可：

     ```
     $ ssh-keygen -t rsa -C "邮箱地址"  
     ```

   - 添加到 github。 复制密钥文件内容（路径形如C:\Users\Administrator\.ssh\id_rsa.pub），粘贴到[New SSH Key](https://github.com/settings/keys)即可。

   - 测试是否添加成功。在命令行（即Git     Bash）依次输入以下命令，返回“You’ve successfully authenticated”即成功：

     ```
     $ ssh -T git@github.com  
     $ yes  
     ```

4. 修改_config.yml（在站点目录下）。文件末尾修改为：

   ```
   # Deployment  
     ## Docs: https://hexo.io/docs/deployment.html  
     deploy:  
     	type: git  
     	repo: git@github.com:<Github账号名称>/<Github账号名称>.github.io.git  
     	branch: master  
   ```

   注意：上面仓库地址写ssh地址，不写http地址。(windows使用git的话建议用https，可以挂代理)

5. 推送到GithubPages。在命令行（即Git Bash）依次输入以下命令， 返回INFO Deploy done: git即成功推送：

   ```
   $ hexo g  
   $ hexo d  
   ```

6. 等待1分钟左右，浏览器访问网址：https://<github账号名称>.github.io

   

至此，的Hexo博客已经搭建在GithubPages, 域名为https://<Github账号名称>.github.io。



## 方案二：GithubPages + 域名

在方案一的基础上，添加自定义域名（购买的域名）。

1. 域名解析。
       类型选择为 CNAME；
       主机记录即域名前缀，填写为www；
       记录值填写为<Github账号名称>.github.io；
       解析线路，TTL 默认即可。

2. 仓库设置。
   - 打开博客仓库设置：https://github.com/<Github账号名称>/<Github账号名称>.github.io/settings
   - 在Custom domain下，填写自定义域名，点击save。
   - 在站点目录的source文件夹下，创建并打开CNAME.txt，写入你的域名，保存，并重命名为CNAME。 

3. 等待10分钟左右。
       浏览器访问自定义域名。
       至此，Hexo博客已经解析到自定义域名，https://<Github账号名称>.github.io依然可用。



# 主题，插件配置

## 主题

hexo博客主题用的是[butterfly](https://github.com/jerryc127/hexo-theme-butterfly)，配置信息：https://jerryc.me/posts/21cfbf15/ ，感谢作者~



## 插件

> 插件部分引自博客https://www.simon96.online/2018/10/12/hexo-tutorial/ ，仅做备份之用以便日后博客迁移可以照着这篇文文章重新恢复(ಥ _ ಥ)

### live2d

- 安装插件

  ```
  npm install --save hexo-helper-live2d
  ```

- 复制你喜欢的模型名字：

   Epsilon2.1

   [![img](https://huaji8.top/img/live2d/Epsilon2.1.gif)](https://huaji8.top/img/live2d/Epsilon2.1.gif)

   Gantzert_Felixander

   [![img](https://huaji8.top/img/live2d/Gantzert_Felixander.gif)](https://huaji8.top/img/live2d/Gantzert_Felixander.gif)

   haru

   [![img](https://huaji8.top/img/live2d/haru.gif)](https://huaji8.top/img/live2d/haru.gif)

   miku

   [![img](https://huaji8.top/img/live2d/miku.gif)](https://huaji8.top/img/live2d/miku.gif)

   ni-j

   [![img](https://huaji8.top/img/live2d/ni-j.gif)](https://huaji8.top/img/live2d/ni-j.gif)

   nico

   [![img](https://huaji8.top/img/live2d/nico.gif)](https://huaji8.top/img/live2d/nico.gif)

   nietzche

   [![img](https://huaji8.top/img/live2d/nietzche.gif)](https://huaji8.top/img/live2d/nietzche.gif)

   nipsilon

   [![img](https://huaji8.top/img/live2d/nipsilon.gif)](https://huaji8.top/img/live2d/nipsilon.gif)

   nito

   [![img](https://huaji8.top/img/live2d/nito.gif)](https://huaji8.top/img/live2d/nito.gif)

   shizuku

   [![img](https://huaji8.top/img/live2d/shizuku.gif)](https://huaji8.top/img/live2d/shizuku.gif)

   tsumiki

   [![img](https://huaji8.top/img/live2d/tsumiki.gif)](https://huaji8.top/img/live2d/tsumiki.gif)

   wanko

   [![img](https://huaji8.top/img/live2d/wanko.gif)](https://huaji8.top/img/live2d/wanko.gif)

   z16

   [![img](https://huaji8.top/img/live2d/z16.gif)](https://huaji8.top/img/live2d/z16.gif)

   hibiki

   [![img](https://huaji8.top/img/live2d/hibiki.gif)](https://huaji8.top/img/live2d/hibiki.gif)

   koharu

   [![img](https://huaji8.top/img/live2d/koharu.gif)](https://huaji8.top/img/live2d/koharu.gif)

   haruto

   [![img](https://huaji8.top/img/live2d/haruto.gif)](https://huaji8.top/img/live2d/haruto.gif)

   Unitychan

   [![img](https://huaji8.top/img/live2d/Unitychan.gif)](https://huaji8.top/img/live2d/Unitychan.gif)

   tororo

   [![img](https://huaji8.top/img/live2d/tororo.gif)](https://huaji8.top/img/live2d/tororo.gif)

   hijiki

   [![img](https://huaji8.top/img/live2d/hijiki.gif)](https://huaji8.top/img/live2d/hijiki.gif)

- 将以下代码添加到主题配置文件`_config.yml`，修改<你喜欢的模型名字>：

   ```yaml
   live2d:
     enable: true
     scriptFrom: local
     pluginRootPath: live2dw/
     pluginJsPath: lib/
     pluginModelPath: assets/
     tagMode: false
     log: false
     model:
       use: live2d-widget-model-<你喜欢的模型名字>
     display:
       position: right
       width: 150
       height: 300
     mobile:
       show: true
   ```

- 建配置文件

   - 在站点目录下建文件夹`live2d_models`，

   - 再在`live2d_models`下建文件夹`<你喜欢的模型名字>`,

   - 再在`<你喜欢的模型名字>`下建json文件：<你喜欢的模型名字>.model.json

- 安装模型。在命令行（即Git Bash）运行以下命令即可：

   ```
   npm install --save live2d-widget-model-<你喜欢的模型名字>
   ```

- 在命令行（即Git Bash）运行以下命令， 在`http://127.0.0.1:4000/`查看测试结果:

   ```
   hexo clean && hexo g && hexo s
   ```



# 进阶配置

## 语雀云端写作+腾讯云serverless提交+ Travis-ci自动构建+github-pages发布

> 实现语雀云端协作部分引自博客https://www.itfanr.cc/2017/08/09/using-travis-ci-automatic-deploy-hexo-blogs/ 以及https://aqpcet.coding.me/%E8%AF%AD%E9%9B%80+TravisCI+Serverless/3689364350.html ，仅做备份之用以便日后博客迁移可以照着这篇文文章重新恢复(ಥ _ ಥ)



- 语雀

  [语雀](https://yuque.com/)是阿里巴巴旗下的专业云端知识库，支持[Markdown](https://baike.baidu.com/item/markdown/3245829?fr=aladdin)语法，个人和团队皆可用于文档编写。它不仅仅是一个在线编写文档的工具，还集成了[Web Hook](https://www.yuque.com/yuque/developer/doc-webhook) ，为自动化部署Hexo建立了基础。而[yuque-hexo](https://github.com/x-cold/yuque-hexo)是[x-cold](https://github.com/x-cold)根据语雀的API为Hexo博客写的插件，可以很方便的将语雀指定知识库里的文章全部更新到hexo博客中。



- Travis CI

  [Travis CI](https://travis-ci.com/)可以很方便地将[GitHub](https://github.com/)的项目持续集成并构建。



- Serverless

  [Serverless](https://cloud.tencent.com/developer/article/1200169)可以通过代码唤起Travis CI执行构建项目。





自动部署总体流程如下。

![图片来自aqpcet.coding.me](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/部署流程.png)



### 关键文件：

- .travis.yml：（参考自[IT范儿](https://www.itfanr.cc/2017/08/09/using-travis-ci-automatic-deploy-hexo-blogs/)）

  如果使用这两个问卷配置travis-ci的话，travis-ci.com上仓库的设置里面环境变量只需要设置Travis_Token，变量值为github上取得的Token（DISPLAY VALUE IN BUILD LOG一定要关上！）

  ```yaml
  language: node_js # 设置语言
  node_js: stable # 设置相应版本
  
  # cache:
  #     apt: true
  #     directories:
  #         - node_modules # 缓存不经常更改的内容
  
  notifications:
      email:
          recipients:
              - happyshark520@outlook.com
          on_success: change
          on_failure: always
  
  before_install:
      - export TZ='Asia/Shanghai'
      - npm install hexo-cli -g
      - npm install cheerio
      - chmod +x ./publish-to-gh-pages.sh
  
  install:
      - npm install
      - npm i -g yuque-hexo
      - npm install hexo-deployer-git --save
  
  script:
      - yuque-hexo clean
      - yuque-hexo sync
      - npm run sync
      - hexo clean
      - hexo g
  
  after_script:
      - ./publish-to-gh-pages.sh
  
  branches:
      only:
          - master #只监测hexo分支，hexo是我的分支的名称，可根据自己情况设置
  env:
      global:
          - GH_REF: github.com/HPShark/HPShark.github.io.git #设置GH_REF，注意更改yourname
  ```

- publish-to-gh-pages.sh：

  ```
  #!/bin/bash
  
  set -ev
  git clone https://${GH_REF} .deploy_git
  cd .deploy_git
  git checkout master
  cd ../
  mv .deploy_git/.git/ ./public/
  cd ./public
  git config user.name "HPShark" # 修改name
  git config user.email "<github登录邮箱>" # 修改email
  # add commit timestamp
  git add .
  git commit -m "Travis CI Auto Builder at `date +"%Y-%m-%d %H:%M"`"
  git push --force --quiet "https://${Travis_Token}@${GH_REF}" master:master
  ```

- 腾讯云serverless函数配置，因为travis-ci.org的网址换成了travis-ci.com，所以要对网上的一些老版本的函数内容中的api部分进行修改，然后再加上token和repos即可

  ```php
  <?php
  function main_handler($event, $context) {
      // 解析语雀post的数据
      $update_title = '';
      if($event->body){
          $yuque_data= json_decode($event->body);
          $update_title .= $yuque_data->data->title;
      }
      // default params
      $repos = '';  // 用户名%2F源码仓库名，斜杠用%2F代替
      $token = ''; // 你的登录token
      $message = date("Y/m/d").':yuque update:'.$update_title;
      $branch = 'master';
      // post params
      $queryString = $event->queryString;
      $q_token = $queryString->token ? $queryString->token : $token;
      $q_repos = $queryString->repos ? $queryString->repos : $repos;
      $q_message = $queryString->message ? $queryString->message : $message;
      $q_branch = $queryString->branch ? $queryString->branch : 'master';
      echo($q_token);
      echo('===');
      echo ($q_repos);
      echo ('===');
      echo ($q_message);
      echo ('===');
      echo ($q_branch);
      echo ('===');
      //request travis ci
      $res_info = triggerTravisCI($q_repos, $q_token, $q_message, $q_branch);
  
      $res_code = 0;
      $res_message = '未知';
      if($res_info['http_code']){
          $res_code = $res_info['http_code'];
          switch($res_info['http_code']){
              case 200:
              case 202:
                  $res_message = 'success';
              break;
              default:
                  $res_message = 'faild';
              break;
          }
      }
      $res = array(
          'status'=>$res_code,
          'message'=>$res_message
      );
      return $res;
  }
  
  /*
  * @description  travis api , trigger a build
  * @param $repos string 仓库ID、slug
  * @param $token string 登录验证token
  * @param $message string 触发信息
  * @param $branch string 分支
  * @return $info array 回包信息
  */
  function triggerTravisCI ($repos, $token, $message='yuque update', $branch='master') {
      //初始化
      $curl = curl_init();
      //设置抓取的url
      curl_setopt($curl, CURLOPT_URL, 'https://api.travis-ci.com/repo/'.$repos.'/requests');
      //设置获取的信息以文件流的形式返回，而不是直接输出。
      curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
      //设置post方式提交
      curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "POST");
      //设置post数据
      $post_data = json_encode(array(
          "request"=> array(
              "message"=>$message,
              "branch"=>$branch
          )
      ));
      $header = array(
        'Content-Type: application/json',
        'Travis-API-Version: 3',
        'Authorization:token '.$token,
        'Content-Length:' . strlen($post_data)
      );
      curl_setopt($curl, CURLOPT_HTTPHEADER, $header);
      curl_setopt($curl, CURLOPT_POSTFIELDS, $post_data);
      //执行命令
      $data = curl_exec($curl);
      $info = curl_getinfo($curl);
      //关闭URL请求
      curl_close($curl);
      return $info;
  }
  ?>
  ```



### 部署过程

1. 源码上传至github

   - 建一个新的仓库，专门存放源代码（也可以直接在github.io 的那个仓库新建一个分支，不过设置麻烦，就放弃了）
   - 将本地代码上传（可能有信息安全风险，所以建议为博客单独开设一个帐号）。注意仓库要设为公开，travis-ci构建私人仓库是要付费的orz..

   注意事项：

   - 上传前建议先执行hexo clean，可以减少上传体积。

   - 也可以通过配置.gitignore控制上传内容

     ```
     .DS_Store
     Thumbs.db
     db.json
     *.log
     node_modules/
     public/
     .deploy*/
     ```

   

2. 配置travis-ci

   - 把.travis.yml和publish-to-gh-pages.sh放在根目录

     - 登录[travis-ci](https://travis-ci.com/)，绑定github，允许访问github仓库，进入**博客源码**仓库

       ![](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/travis设置.png)

     - 设置Environment Variables(环境变量)，设置Travis_Token

       ![](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/travis的token设置.png)

     - 配置完成后等待腾讯云serverless触发即可构建，构建成功会return 0，如果有其他问题（一般是缺环境）缺啥在.travis.yml中的install那里npm装包即可~

       

3. 腾讯云serverless函数配置：

   - 新建php空白函数：（可以用python，aqpcet.coding.me用的就是python设置的）

     ![](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/serverless新建plp文件.png)

   - 编辑serverless函数内容，需要获取以下两个信息，填入对应的地方就行

     - travis登录token，在travis-ci.com中设置界面获取：

       ![](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/travis登录token.png)

     - 博客源码的仓库名

       现在可以直接用\<github用户名>%2F<博客源码仓库名>代替原来的仓库id了，不用在拿抓包工具抓仓库ID 或 扩展名了

   - 配置触发方式

     ![](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/serverless设置触发方式.png)

     一般会得到这么个api：https://service-s08f6nvk-1251833201.ap-guangzhou.apigateway.myqcloud.com/release/xxx

4. 语雀配置：

   配置一个仓库的webhook:

   ![](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/语雀配置.png)

   可以选择所有更新触发或者主动触发，主动触发的意思即发布需要勾选一个选项才会触发webhook。具体可参见语雀文档：https://www.yuque.com/yuque/developer/doc-webhook；
   将serverless生成的api填入,可以在链接后面带参数：

   ```
   token 登录token
   repos 仓库id
   message 提交信息
   branch 分支
   
   示例：
   https://service-s08f6nvk-1251833201.ap-guangzhou.apigateway.myqcloud.com/release/xxx?repos=xxx&token=xxx&message=xxx&branch=xxx
   ```

   如果不在链接带参数则写在serverless函数内。

### 通过语雀插件对front-matter进行处理

插件地址：https://github.com/x-cold/yuque-hexo

需要对package.json，.travis.yml进行配置，在编辑语雀文章时头部要这么写：

```
tags: [hexo, node]
categories: fe
cover: https://cdn.nlark.com/yuque/0/2019/jpeg/155457/1546857679810-d82e3d46-e960-419c-a715-0a82c48a2fd6.jpeg#align=left&display=inline&height=225&name=image.jpeg&originHeight=225&originWidth=225&size=6267&width=225

---

some description

<!-- more -->

more detail
```

注：冒号后面是**空格**！tags后面必须有中**括号**！有时候同步完之后空格会变成tab造成front-matter无法被插件识别，就会出现front-matter重叠的情况[issues#45](https://github.com/x-cold/yuque-hexo/issues/45)



**大功告成！在语雀上正常发布一篇文章即可自动触发serverless函数提交给travis-ci构建博客**



# 一些坑

## serverless python版

![](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/serverlesspython版.png)



## 私人图床：onedrive

使用方法非常简单，具体步骤如下：

- 注册账户，已有的可直接略过。

- 登录OneDrive，上传需要外链的图片。

- 在图片上右键选择“嵌入”按钮，再在弹出的窗口中点击“生成”选项。

- 将链接复制到需要展示的地方。

来自 <https://osk.ink/archives/12/> 



## travis渲染时报错：

> travis /bin/bash^M: bad interpreter: No such file or directory
>
>  
>
> If you use **Sublime Text** on Windows or Mac to edit your scripts:
>
> Click on View > Line Endings > Unix and **save** the file again.

原因：编码问题，如下解决即可

![](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/travis编码报错解决.png)



## Ubuntu安装Proxychains

Proxychains是Linux上一款全局代理工具，通过Hook Socket函数实现透明代理，这和Windows上的Proxifier有点类似。 在Ubuntu上安装Proxychains的方法是：

```
apt-get install proxychains 
```

安装的是3.1版本，配置文件的路径是：/etc/proxychains.conf，内容如下：

```
# proxychains.conf  VER 3.1
#
#        HTTP, SOCKS4, SOCKS5 tunneling proxifier with DNS.
#
# The option below identifies how the ProxyList is treated.
# only one option should be uncommented at time,
# otherwise the last appearing option will be accepted
#
#dynamic_chain
#
# Dynamic - Each connection will be done via chained proxies
# all proxies chained in the order as they appear in the list
# at least one proxy must be online to play in chain
# (dead proxies are skipped)
# otherwise EINTR is returned to the app
#
strict_chain
#
# Strict - Each connection will be done via chained proxies
# all proxies chained in the order as they appear in the list
# all proxies must be online to play in chain
# otherwise EINTR is returned to the app
#
#random_chain
#
# Random - Each connection will be done via random proxy
# (or proxy chain, see  chain_len) from the list.
# this option is good to test your IDS :)
# Make sense only if random_chain
#chain_len = 2
# Quiet mode (no output from library)
#quiet_mode
# Proxy DNS requests - no leak for DNS data
proxy_dns 
# Some timeouts in milliseconds
tcp_read_time_out 15000
tcp_connect_time_out 8000
# ProxyList format
#       type  host  port [user pass]
#       (values separated by 'tab' or 'blank')
#
#
#        Examples:
#
#               socks5  192.168.67.78   1080    lamer   secret
#               http    192.168.89.3    8080    justu   hidden
#               socks4  192.168.1.49    1080
#               http    192.168.39.93   8080
#
#
#       proxy types: http, socks4, socks5
#        ( auth types supported: "basic"-http  "user/pass"-socks )
#
[ProxyList]
# add proxy here ...
# meanwile
# defaults set to "tor"
socks4         127.0.0.1 9050

```

Proxychains支持HTTP（HTTP-Connect）、SOCKS4和SOCKS5三种类型的代理，需要注意的是：配置代理服务器只能使用ip地址，不能使用域名，否则会连不上。

Proxychains支持3种模式： 

1. 动态模式 按照配置的代理顺序连接，不存活的代理服务器会被跳过 
2. 严格模式     按照配置的代理顺序连接，必须保证所有代理服务器都是存活的，否则会连接失败 
3. 随机模式     随机选择一台代理服务器连接，也可以使用代理链

如果不需要代理DNS的话，可以注释掉proxy_dns这行。

使用的时候在命令行前加上proxychains即可。

```
root@ubuntu-pc:~# proxychains telnet [www.baidu.com](http://www.baidu.com) 80 ProxyChains-3.1 ([http://proxychains.sf.net](http://proxychains.sf.net/)) Trying 14.215.177.37… |R-chain|-<>-10.0.0.10:8080-<><>-14.215.177.37:80-<><>-OK Connected to [www.a.shifen.com](http://www.a.shifen.com). Escape character is ‘^]’. 

proxychains命令其实是个脚本文件，内容如下：

\#!/bin/sh
 echo "ProxyChains-3.1 (http://proxychains.sf.net)"
 if [ $# = 0 ] ; then
     echo " usage:"
     echo "     proxychains <prog> [args]"
     exit
 fi
 export LD_PRELOAD=libproxychains.so.3
 exec "$@"
```

它的目的是设置LD_PRELOAD环境变量，以便创建的新进程会加载libproxychains.so.3，这个so的作用是Hook Socket函数。因此，也可以在当前shell中执行： 

```
export LD_PRELOAD=libproxychains.so.3
```

这样之后执行的命令都会使用代理访问。

不过这个版本有个问题，配置代理后所有的连接都会走代理，包括对回环地址的访问。这并不是我们所期望的，幸好有个版本提供了解决方案。

```
git clone https://github.com/rofl0r/proxychains cd proxychains ./configure make make install 
```

安装后在配置文件中加入：

```
localnet 127.0.0.0/255.0.0.0 
```

安装后的命令是proxychains4，因此可以和旧版本命令并存。这样对于回环地址就可以绕过代理，使用直连了。

相对于Proxifier而言，这种方式还是弱了一点，毕竟有时候我们还是需要根据不同的情况使用不同的代理服务器。



## 有东西传不到github上去？

删掉.deploy_git:

```
- rm -rf .deploy_git/
```



## 语雀防盗链解决办法：

临时方案是直接在 html 模版中添加 head 进行绕过

```html
<meta name="referrer" content="no-referrer" />
```

 (来自 <https://github.com/x-cold/yuque-hexo/issues/41> )

注：对于butterfly主题的话对themes\Butterfly\layout\includes\layout.pug修改head部分即可，但是会造成网站访客数和文章阅读数无法加载



## gem失败

apt-get install ruby-dev 



如果使用windows子系统的Ubuntu的话，可能会出现Windows 的 Linux 子系统的文件同步和 Windows 不是实时的问题（来自 <https://www.zhihu.com/question/318832524/answer/641951256> ）

你可以在Windows下存储文件，然后在wsl中使用/mnt/盘符/路径 访问

你也可以在1903更新发布后在Linux rootfs中存储文件，Windows程序使用\\wsl$\Ubuntu\unix路径 访问

唯独不正确的操作是找到AppData里rootfs文件夹直接用Windows程序修改，因为这里面的文件在NTFS中除了存储文件内容，Windows文件元数据，还存储unix文件元数据（比如rwx权限，unix用户组和用户），你创建的文件并不具有这样的属性，因此会导致权限混乱。

详见：[https://blogs.msdn.microsoft.com/commandline/2016/11/17/do-not-change-linux-files-using-windows-apps-and-tools/](https://link.zhihu.com/?target=https%3A//blogs.msdn.microsoft.com/commandline/2016/11/17/do-not-change-linux-files-using-windows-apps-and-tools/)

1903（19H1，20195月更新）的改动

**Linux Files inside of File Explorer**

The best way to get started with this feature is to open your Linux files in File Explorer! To do this, open your favorite distro, make sure your current folder is your Linux home directory, and type in:

```
explorer.exe .
```

来自 <https://devblogs.microsoft.com/commandline/whats-new-for-wsl-in-windows-10-version-1903/> 



# 参考：

- [语雀+TravisCI+Serverless]: https://segmentfault.com/a/1190000017797561

- [【持续更新】最全Hexo博客搭建+主题优化+插件配置+常用操作+错误分析]: https://www.simon96.online/2018/10/12/hexo-tutorial/

- [使用Travis CI自动部署Hexo博客]: https://www.itfanr.cc/2017/08/09/using-travis-ci-automatic-deploy-hexo-blogs/

- [hexo-theme-butterfly安裝文檔]: https://jerryc.me/posts/21cfbf15/

- [Hexo 博客终极玩法：云端写作，自动部署]: https://segmentfault.com/a/1190000017797561

  

