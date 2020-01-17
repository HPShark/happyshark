---
title: hexo博客上线
date: 2019-12-26 14:00:00
tags:
    - hexo
    - travis CI
    - 语雀
---
    博客又双叒叕上线了，这次使用的是hexo + Github Pages + travis CI + 语雀 + serverless + onedrive图床，部署完成之后可以直接在语雀上编辑文章然后自动发布到博客，云端写作不是梦hhh 



# 部署

> 部署部分是按照博客https://www.simon96.online/2018/10/12/hexo-tutorial/配置的，仅做备份之用以便日后博客迁移可以照着这篇文文章重新恢复(ಥ _ ಥ)

本地环境：windows Linux Ubuntu 18.04

- （可选）配置git

  首先我得重新在git设置一下身份的名字和邮箱（因为当初都忘了设置啥了，因为遇到坑了）进入到需要提交的文件夹底下（因为直接打开git Bash，在没有路径的情况下，根本没！法！改！刚使用git时遇到的坑。。。）

  ```
  git config --global user.name "yourname"
  git config --global user.email“your@email.com"
  ```

  注：yourname是你要设置的名字，your@email是你要设置的邮箱。

- 安装 Node.js和npm

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

- 安装 Hexo

  - 创建博客所在目录

     ```
     mkdir hexo 
     ```

  - 创建目录

     ```
     mkdir hexo
     ```

  - 切换目录

      ``` 
      cd hexo
      ```

  - 全局安装 Hexo，需要最高权限，记得输入root密码

      ``` 
      sudo npm install -g hexo-cli
      ```

  - 初始化 Hexo

      ```
      hexo init
      ```

  	注：如果报错执行代码,不报错忽略

      ```
      sudo npm config set user 0
      sudo npm config set unsafe-perm true
      sudo npm install -g hexo-cli
      ```

- 安装插件

  - 如果安装慢就安装proxychains，并且定义alias npm='proxychains4 npm'

  - 如果要永久定义（重启不失效的话就编辑：

    ```
    vim ~/.bashrc
    ```
    
    并且在末尾添加以下代码并定义 alias
    
    ```
    alias npm='proxychains4 npm'
    ```

  - 配置完代理后就可以安装npm插件了

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
  
- 测试安装成功

  ```
  hexo g && hexo server
  ```

  ![本地部署成功](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/部署成功.png)



# 同步到githubpages

### 方案一：GithubPages

- 创建[Github](https://github.com/)账号

- 创建仓库， 仓库名为：<Github账号名称>.github.io

- 将本地Hexo博客推送到GithubPages

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

    

- 修改_config.yml（在站点目录下）。文件末尾修改为：

  ```
  # Deployment  
  ## Docs: https://hexo.io/docs/deployment.html  
  deploy:  
  	type: git  
  	repo: git@github.com:<Github账号名称>/<Github账号名称>.github.io.git  
  	branch: master  
  ```

  注意：上面仓库地址写ssh地址，不写http地址。(windows使用git的话建议用https，可以挂代理)

- 推送到GithubPages。在命令行（即Git Bash）依次输入以下命令， 返回INFO Deploy done: git即成功推送：

  ```
    $ hexo g  
    $ hexo d  
  ```

- 等待1分钟左右，浏览器访问网址：https://<github账号名称>.github.io



至此，的Hexo博客已经搭建在GithubPages, 域名为https://<Github账号名称>.github.io。



### 方案二：GithubPages + 域名

在方案一的基础上，添加自定义域名（购买的域名）。

- 域名解析。
      类型选择为 CNAME；
      主机记录即域名前缀，填写为www；
      记录值填写为<Github账号名称>.github.io；
      解析线路，TTL 默认即可。

- 仓库设置。
  - 打开博客仓库设置：https://github.com/<Github账号名称>/<Github账号名称>.github.io/settings
  - 在Custom domain下，填写自定义域名，点击save。
  - 在站点目录的source文件夹下，创建并打开CNAME.txt，写入你的域名，保存，并重命名为CNAME。 

- 等待10分钟左右。
      浏览器访问自定义域名。
      至此，Hexo博客已经解析到自定义域名，https://<Github账号名称>.github.io依然可用。



# 主题，插件配置

hexo博客主题用的是[butterfly](https://github.com/jerryc127/hexo-theme-butterfly)，配置信息：https://jerryc.me/posts/21cfbf15/，感谢作者~

> 插件部分引自博客https://www.simon96.online/2018/10/12/hexo-tutorial/，仅做备份之用以便日后博客迁移可以照着这篇文文章重新恢复(ಥ _ ಥ)
>

### live2d：



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

   ```
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

### 语雀云端写作+腾讯云serverless提交+ Travis-ci自动构建+github-pages发布

> 实现语雀云端协作部分引自博客https://www.itfanr.cc/2017/08/09/using-travis-ci-automatic-deploy-hexo-blogs/以及[https://aqpcet.coding.me/%E8%AF%AD%E9%9B%80+TravisCI+Serverless/3689364350.html](https://aqpcet.coding.me/语雀+TravisCI+Serverless/3689364350.html)，仅做备份之用以便日后博客迁移可以照着这篇文文章重新恢复(ಥ _ ಥ)



- 语雀

  [语雀](https://yuque.com/)是阿里巴巴旗下的专业云端知识库，支持[Markdown](https://baike.baidu.com/item/markdown/3245829?fr=aladdin)语法，个人和团队皆可用于文档编写。它不仅仅是一个在线编写文档的工具，还集成了[Web Hook](https://www.yuque.com/yuque/developer/doc-webhook) ，为自动化部署Hexo建立了基础。而[yuque-hexo](https://github.com/x-cold/yuque-hexo)是[x-cold](https://github.com/x-cold)根据语雀的API为Hexo博客写的插件，可以很方便的将语雀指定知识库里的文章全部更新到hexo博客中。



- Travis CI

  [Travis CI](https://travis-ci.com/)可以很方便地将[GitHub](https://github.com/)的项目持续集成并构建。



- Serverless

  [Serverless](https://cloud.tencent.com/developer/article/1200169)可以通过代码唤起Travis CI执行构建项目。





自动部署总体流程如下。

![图片来自aqpcet.coding.me](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/部署流程.png)



#### 关键文件：

- .travis.yml：（参考自[IT范儿](https://www.itfanr.cc/2017/08/09/using-travis-ci-automatic-deploy-hexo-blogs/)）

  如果使用这两个问卷配置travis-ci的话，travis-ci.com上仓库的设置里面环境变量只需要设置Travis_Token，变量值为github上取得的Token（DISPLAY VALUE IN BUILD LOG一定要关上！）

  ```
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

  ```
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



#### 部署过程

- 源码上传至github

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

- 配置travis-ci

  - 把.travis.yml和publish-to-gh-pages.sh放在根目录

  - 登录[travis-ci](https://travis-ci.com/)，绑定github，允许访问github仓库，进入**博客源码**仓库

    ![](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/travis设置.png)

  - 设置Environment Variables(环境变量)，设置Travis_Token

    ![](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/travis的token设置.png)

  - 配置完成后等待腾讯云serverless触发即可构建，构建成功会return 0，如果有其他问题（一般是缺环境）缺啥在.travis.yml中的install那里npm装包即可~

- 腾讯云serverless函数配置：

  - 新建php空白函数：（可以用python，aqpcet.coding.me用的就是python设置的）

    ![](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/serverless新建plp文件.png)

  - 编辑serverless函数内容，需要获取以下两个信息，填入对应的地方就行

    - travis登录token，在travis-ci.com中设置界面获取：

      ![](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/travis登录token.png)

    - 博客源码的仓库名

      现在可以直接用<github用户名>%2F<博客源码仓库名>代替原来的仓库id了，不用在拿抓包工具抓仓库ID 或 扩展名了

- ##### 配置触发方式
  
  ![](https://raw.githubusercontent.com/HPShark/blogimages/master/hello-world/serverless设置触发方式.png)
  
  一般会得到这么个api：https://service-s08f6nvk-1251833201.ap-guangzhou.apigateway.myqcloud.com/release/xxx
  
- 语雀配置：

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

