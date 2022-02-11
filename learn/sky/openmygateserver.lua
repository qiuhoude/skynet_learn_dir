local skynet = require "skynet"

-- openmygateserver
skynet.start(function()
    skynet.error("Server start")
    local gateserver = skynet.newservice("mygateserver") --启动的网关服务
    skynet.call(gateserver, "lua", "open", {   --需要给网关服务发送open消息，来启动监听
        port = 8083,            --监听的端口
        maxclient = 2,         --客户端最大连接数
        nodelay = true,         --是否延迟TCP
    })

    skynet.error("gate server setup on", 8083)
    skynet.exit()
end)