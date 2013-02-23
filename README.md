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
    Qq.redo("scope参数") #scope参数即请求用户授权时向用户显示的可进行授权的列表。
可填写的值是【QQ登录】API文档中列出的接口，以及一些动作型的授权（目前仅有：do_like），如果要填写多个接口名称，请用逗号隔开。
例如：Qq.redo("get_user_info,list_album,upload_pic,add_share")
不传则默认请求对接口get_user_info进行授权。
