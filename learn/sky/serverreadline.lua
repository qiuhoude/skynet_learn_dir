local skynet = require "skynet"
local socket = require "skynet.socket"

-- serverreadline
local function echo(cID, addr)
    socket.start(cID)
    while true do
        local str = socket.readline(cID)
        if str then
            skynet.fork(function()
                skynet.error("recv " .. str)
                skynet.sleep(math.random(1, 5) * 100)
                socket.write(cID, string.upper(str) .. "\n")
            end)
        else
            socket.close(cID)
            skynet.error(addr .. " disconnect")
            
            return
        end
    end
end

local function accept(id, addr)
    skynet.error(addr .. " accepted")
    skynet.fork(echo, id, addr)
end

-- 服务入口
skynet.start(function()
    local addr = "0.0.0.0:8083"
    skynet.error("listen " .. addr)
    local id = socket.listen(addr)
    assert(id)
    socket.start(id, accept)
end)
