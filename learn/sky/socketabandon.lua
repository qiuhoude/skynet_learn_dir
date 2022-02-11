local skynet = require "skynet"
local socket = require "skynet.socket"

local function accept(id, addr)
    skynet.error(addr .. " acccepted")
    -- 当前服务开始使用套接字
    socket.start(id)
    local str = socket.read(id)
    if (str) then socket.write(id, string.upper(str)) end
    -- 不想使用了，这个时候遗弃控制权
    socket.abandon(id)
    skynet.newservice("socketagent", id, addr)
end

skynet.start(function()
    local addr = "0.0.0.0:8083"
    local id = socket.listen(addr)
    skynet.error("listen -> " .. addr .. " co:", coroutine.running())
    assert(id)
    socket.start(id, accept)

    -- socketabandon
end)
