QQ Connect SDK for Ruby On Rails
================

### 警告:

从`0.1.1`开始,重新设计了整套SDK,因此并不向下兼容.

若你不需要使用新的API,则可以保留旧版本.

### 安装:
    
在你的Gemfile里新增一行

`gem 'qq', :git => 'git://github.com/infinityBlue/qq.git'`

然后

`bundle install`

### 使用:
配置
```Ruby
#config/initializer/qq.rb
QQ::Config.appid = xxx
QQ::Config.appkey = xxx
QQ::Config.redirect_uri = xxx
```

跳转至授权页获取code
```Ruby
client = QQ::Client.new
redirect_to client.authorize_url
```
回调页使用code获取用户信息：

```Ruby
user=QQ::User.new(params[:code])
user.name
user.avatar
user.openid
```



### 授权:

MIT
