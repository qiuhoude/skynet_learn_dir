local skynet = require "skynet"

-- start Server
skynet.start(function ()
    skynet.error("=======开始启动服务====")
    -- 启动一个新的 Lua 服务(服务脚本文件名)
--[[     
    local server = skynet.newservice("houde_db")
    skynet.call(server,"lua","set","name","qiu")
    local kv = skynet.call(server,"lua","get","name")
    skynet.error("kv -> ",kv) ]]
    -- skynet.exit 之后的代码都不会被运行。而且，当前服务被阻塞住的 coroutine 也会立刻中断退出。
    -- skynet.newservice("socket1")
    skynet.newservice("socket2")
    skynet.exit()
end)