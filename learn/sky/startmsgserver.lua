local skynet = require "skynet"

-- startmsgserver
skynet.start(function()
    local gate = skynet.newservice("mymsgserver") 
    --网关服务需要发送lua open来打开，open也是保留的命令
    skynet.call(gate, "lua", "open" , { 
        port = 8002,
        maxclient = 64,
        servername = "sample",  --取名叫sample，跟使用skynet.name(".sample")一样
    })

    local uid = "qiu"
    local secret = "11111111"
    local subid = skynet.call(gate, "lua", "login", uid, secret) --告诉msgserver，nzhsoft这个用户可以登陆
    skynet.error("lua login subid", subid)
    skynet.call(gate, "lua", "logout", uid, subid) --告诉msgserver，nzhsoft登出
    skynet.call(gate, "lua", "kick", uid, subid) --告诉msgserver，剔除nzhsoft连接
    skynet.call(gate, "lua", "close")   --关闭gate，也就是关掉监听套接字
end)