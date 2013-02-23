QQ Connect SDK for Ruby On Rails
================
    
###安装:
    
在你的Gemfile里新增一行

`gem 'qq', :git => 'git://github.com/046569/qq.git'`

然后

`bundle install`

###使用:

在你喜欢的地方定义:

`APPID='你的ID'`

`APPKEY='你的key'`

`REDURL='&redirect_uri=你的跳转地址'`

获得登录按钮链接地址：

`Qq.redo("get_user_info,list_album,upload_pic,add_share")`

相关参数请查阅[QQ互联开放平台](http://connect.qq.com/intro/login/)