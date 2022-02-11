local skynet = require "skynet"

skynet.start(function()
    skynet.error("Server First Test")
    -- skynet.exit() 不要尝试服务初始化阶段退出服务，唯一服会创建失败
end)
