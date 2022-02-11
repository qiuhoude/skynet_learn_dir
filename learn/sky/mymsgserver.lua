local msgserver = require "snax.msgserver"
local crypt = require "skynet.crypt"
local skynet = require "skynet"

local loginservice = tonumber(...) --从启动参数获取登录服务的地址
local subid = 0
local server = {}  --一张表，里面需要实现前面提到的所有回调接口
local servername

--外部发消息来调用，一般用来注册可以登陆的登录名
function server.login_handler(uid, secret) 
    skynet.error("login_handler invoke", uid, secret)
    subid = subid + 1
     --通过uid以及subid获得username
    local username = msgserver.username(uid, subid, servername)
    skynet.error("uid",uid, "login，username", username)
    msgserver.login(username, secret)--正在登录，给登录名注册一个secret
    return subid
end

--外部发消息来调用，注销掉登陆名
function server.logout_handler(uid, subid)
    skynet.error("logout_handler invoke", uid, subid)
    local username = msgserver.username(uid, subid, servername)
    msgserver.logout(username)
end

--外部发消息来调用，用来关闭连接
function server.kick_handler(uid, subid)
    skynet.error("kick_handler invoke", uid, subid)
end

--当客户端断开了连接，这个回调函数会被调用
function server.disconnect_handler(username) 
    skynet.error(username, "disconnect")
end

--当接收到客户端的请求，这个回调函数会被调用,你需要提供应答。
function server.request_handler(username, msg)
    skynet.error("recv", msg, "from", username)
    return string.upper(msg)
end

--监听成功会调用该函数，name为当前服务别名
function server.register_handler(name)
    skynet.error("register_handler invoked name", name)
    servername = name
    skynet.call(loginservice, "lua", "register_gate", servername, skynet.self())
end

msgserver.start(server) --需要配置信息