local skynet = require "skynet"
local socket = require "skynet.socket"

local id, addr = ...
id = tonumber(id)

local function echo(id, addr)
    socket.start(id) -- 必须使用 start才能进行read消息
    print(" echo co :", coroutine.running())
    while true do
        local str = socket.read(id)
        -- local str, endstr = socket.readline(id)
        if str then
            skynet.error(addr .. " _recv <-" .. str)
            socket.write(id, str:upper())
            -- 由于cpu处理非常快，无法看到效果，只有当cpu复核过高的时候，才会出现低优先级后发送的现象
            socket.lwrite(id, str:upper())
        else
            socket.close(id)
            -- if endstr then skynet.error("last recv " .. endstr) end
            skynet.error(addr .. " disconnect")
            break
        end
    end
    skynet.error(addr .. " 已经断开连接")
end

skynet.start(function()
    skynet.fork(function()
        echo(id, addr)
        skynet.exit()
    end)
    -- socketagent
end)
