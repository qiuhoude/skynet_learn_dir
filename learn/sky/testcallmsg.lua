local skynet = require "skynet"
require "skynet.manager"

skynet.start(function()
    --[[  发送lua类型的消息给service，发送成功，该函数将阻塞等待响应返回，r的值为响应的返回值 ]]
    skynet.register ".testcallmsg"
    local r = skynet.call(".testluamsg", "lua", 1, "Twitter", true)
    skynet.error("skynet.call return value:", r)

    --[[ 通过skynet.pack来打包发送，返回的值也需要自己解包 ]]
    local msg, sz = skynet.pack(skynet.pack(2, "Twitter", false))
    r = skynet.unpack(skynet.rawcall(".testluamsg", "lua", msg, sz))
    skynet.error("skynet.rawcall return value:", r)
end)
