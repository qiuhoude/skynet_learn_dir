local skynet = require "skynet"
require "skynet.manager"

local function dosomething(session, address, ...)
    skynet.error("session : ", session)
    skynet.error("address : ", skynet.address(address))
    local args = {...}
    for k, v in pairs(args) do skynet.error("arg" .. k .. ":", v) end
    return 100, false
end

skynet.start(function()
    skynet.dispatch("lua", function(session, address, ...)

       --[[  skynet.retpack(dosomething(session, address, ...)) -- 申请响应消息C内存 ]]
        skynet.ret(skynet.pack(dosomething(session, address, ...)))

    end) -- skynet.dispatch完成后,释放调用接收消息C内存
    skynet.register ".testluamsg"
end)
