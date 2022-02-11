local skynet = require "skynet"
require "skynet.manager"

local realsvr = ...

skynet.register_protocol {
    name = "system",
    id = skynet.PTYPE_SYSTEM,
    unpack = function(...) return ... end -- 传什么返回什么,不进行 unpack pack处理
}
local forward_map = {
    -- 发送到代理服务的lua消息全部转成system消息,不改变原先LUA的消息协议处理方式
    [skynet.PTYPE_LUA] = skynet.PTYPE_SYSTEM,
    -- 如果接收到应答消息，默认情况下会释放掉消息msg,sz，forward的方式处理消息不会释放掉消息msg,sz
    [skynet.PTYPE_RESPONSE] = skynet.PTYPE_RESPONSE
}

-- 使用 forward_type 替代 start
skynet.forward_type(forward_map, function() -- 注册消息处理函数
    skynet.dispatch("system",
                    function(session, source, msg, sz) -- 接收到消息msg，sz
        skynet.ret(skynet.rawcall(realsvr, "lua", msg, sz)) -- 根据参数列表重新打包消息转发
    end) -- 释放消息msg,sz
    skynet.register(".proxy")
end)

--[[ skynet.start(function() -- 注册消息处理函数
    skynet.dispatch("lua",
                    function(session, source, ...) -- 接收到消息msg，sz
        skynet.ret(skynet.rawcall(realsvr, "lua", skynet.pack(...))) -- 根据参数列表重新打包消息转发
    end) -- 释放消息msg,sz
    skynet.register(".proxy")
end) ]]
