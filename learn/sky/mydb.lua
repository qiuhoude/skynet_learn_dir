local skynet = require "skynet"
local queue = require "skynet.queue" -- 执行队列
local cs = queue() -- 创建执行队列

require "skynet.manager" -- import skynet.register

local db = {}

local command = {}

function command.GET(key)
    skynet.sleep(math.random(800, 1000))
    return db[key]
end

function command.SET(key, value)
    local last = db[key]
    db[key] = value
    return last
end

skynet.start(function()
    -- 注册该服务的lua消息回调函数
    skynet.dispatch("lua", function(session, address, cmd, ...)
        -- 接受到的第一参数作为命令使用
        cmd = cmd:upper()
        local f = command[cmd] -- 查询cmd命令的具体处理方法
        if f then
            -- 执行查询到的方法，并且通过skynet.ret将执行结果返回
            -- 将f丢到队列中去执行，队列中的函数严格按照先后顺序进行执行
            skynet.ret(skynet.pack(cs(f, ...)))
            -- skynet.ret(skynet.pack(f(...)))
        else
            skynet.error(string.format("Unknown command %s", tostring(cmd)))
        end
    end)
    skynet.register ".mydb" -- 给当前服务注册一个名字，便于其他服务给当前服务发送消息
end)

 