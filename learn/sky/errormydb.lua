local skynet = require "skynet"
require "skynet.manager" -- import skynet.register

local db = {}

local command = {}

function command.GET(key) return db[key] end

function command.SET(key, value)
    local last = db[key]
    db[key] = value
    return last
end

skynet.start(function()
    -- 注册该服务的lua消息回调函数
    skynet.dispatch("lua", function(session, address, cmd, ...)
        skynet.error("lua dispatch ", coroutine.running()) -- 这个协程接收消息的

        -- 先把发送服务地址以及session打包到闭包中，可以在任意地方调用
        local response = skynet.response(skynet.pack) -- 指定打包函数，必须根据接收到的消息打包函数一致

        skynet.fork(
            function(cmd, ...) -- 开启一个新的协程来处理响应
                local cc = cmd:upper()
                skynet.error("fork ", coroutine.running(), ", cc:", cc)
                local f = command[cc] -- 查询cmd命令的具体处理方法
                if f then
                    -- 执行查询到的方法，并且通过skynet.ret将执行结果返回
                    -- skynet.ret(skynet.pack(f(...)))

                    -- 使用sresponse替代ret 解决不同线程中回复消息
                    response(true, f(...)) -- 第一个参数true表示应答成功，false则应答个错误消息
                else
                    skynet.error(string.format("Unknown command %s",
                                               tostring(cc)))
                end
            end, cmd, ...)
    end)
    skynet.register ".mydb" -- 给当前服务注册一个名字，便于其他服务给当前服务发送消息
end)
