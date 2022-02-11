local skynet = require "skynet"
require "skynet.manager" -- inject skynet.forward_type

skynet.register_protocol { -- 注册system消息
    name = "system",
    id = skynet.PTYPE_SYSTEM,
    -- pack = skynet.pack,
    unpack = skynet.unpack -- unpack必须指定一下，接收到消息后会自动使用unpack解析
}

skynet.start(function()
    skynet.dispatch("system",
                    function(session, address, ...) -- 使用unpack解包
        skynet.ret(skynet.pack("Twitter~~~~"))
        -- 使用skynet.retpack的时候，必须要在skynet.register_protocol指定pack
        -- skynet.retpack("Twitter")
    end)
    skynet.register ".othermsg"
end)
