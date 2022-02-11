local skynet = require "skynet"
local harbor = require "skynet.harbor"

skynet.start(function()
    local globalluamsg = harbor.queryname("globalluamsg")
    local r = skynet.call(globalluamsg, "lua", "nengzhong")
    skynet.error("skynet.call return value:", r)

end)
