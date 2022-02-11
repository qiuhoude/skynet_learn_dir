local skynet = require "skynet"

skynet.register_protocol { -- 注册system消息
    name = "system",
    id = skynet.PTYPE_SYSTEM
    -- pack = skynet.pack,
    -- unpack = skynet.unpack -- unpack必须指定一下，接收到消息后会自动使用unpack解析
}

skynet.start(function()
    local othermsg = skynet.localname(".othermsg")
    local msg, sz = skynet.rawcall(othermsg, "system",
                                   skynet.pack(1, "Twitter", true))

    -- 使用skynet.call的时候必须要在skynet.register_protocol指定pack与unpack
    -- local r = skynet.call(othermsg, "system", 1, "Twitter", true)
    local r = skynet.unpack(msg, sz)
    print("r -> ", r)
end)
