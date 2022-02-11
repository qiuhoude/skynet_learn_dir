local skynet = require "skynet"
require "skynet.manager"

skynet.start(function()
    skynet.register ".testsendmsg" -- 注册
    local testluamsg = skynet.localname(".testluamsg") -- 获取 testluamsg 服务句柄
    -- 发送lua类型的消息给testluamsg，发送成功后立即返回，r的值为0
    local r = skynet.send(testluamsg, "lua", 1, "Twitter", true) -- 申请了C内存（msg，sz）已经用与发送，所以不用自己再释放内存了。
    skynet.error("skynet.send return value:", r)

    -- 通过skynet.pack来打包发送
    local msg, sz = skynet.pack(2, "Twitter", false)
    r = skynet.rawsend(testluamsg, "lua", msg, sz) -- 申请了C内存（msg，sz）已经用与发送，所以不用自己再释放内存了。
    -- skynet.trash(msg, sz) 释放消息
    skynet.error("skynet.rawsend return value:", r)
    
end)
