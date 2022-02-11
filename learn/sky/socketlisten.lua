local skynet = require "skynet"
local socket = require "skynet.socket"

local function accept(id, addr)
    skynet.error(addr .. " acccepted")
    skynet.newservice("socketagent", id, addr)
end

skynet.start(function()
    local addr = "0.0.0.0:8083"
    local id = socket.listen(addr)
    skynet.error("listen -> " .. addr .. " co:", coroutine.running())
    assert(id)
    socket.start(id, accept)
    -- socketlisten
end)


