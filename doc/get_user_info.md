get\_user\_info
=====================================================
获取登录用户信息，目前可获取用户在QQ空间的昵称、头像信息及黄钻信息。
----------------------------------------------------
    
* 请求的地址
    
    https://graph.qq.com/user/get\_user\_info 

* 支持的格式

    json,xml

* 请求的方式

    get

* 私有参数说明

    format:定义API返回的数据格式.

* 请求的示例

    https://graph.qq.com/user/get\_user\_info?access_token=\*\*\*\*\*\*\*\*\*\*&oauth_consumer_key=12345&openid=\*\*\*\*\*\*\*\*\*\*&format=json

* 返回参数说明

    ret: 返回码

    msg: 如果ret<0，会有相应的错误信息提示，返回数据全部用UTF-8编码

    nickname: 昵称

    figureurl: 大小为30×30像素的头像URL

    figureurl\_1: 大小为50×50像素的头像URL

    figureurl\_2: 大小为100×100像素的头像URL

    gender: 性别。如果获取不到则默认返回“男”

    vip: 标识用户是否为黄钻用户（0：不是；1：是）

    level: 黄钻等级（如果是黄钻用户才返回此参数）

* 返回码说明

    ret=0为正确,其他为错误.
