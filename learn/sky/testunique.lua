local skynet = require "skynet"

print("uniqueservice call ..... ")
local args = { ... }
if(#args == 0) then
    table.insert(args, "uniqueservice")
end

skynet.start(function()
    local us
    skynet.error("test unique service testunique")
    if ( #args == 2 and args[1] == "true" )  then
        us = skynet.uniqueservice(true, args[2])
    else
        us =skynet.uniqueservice(args[1])
    end
    skynet.error("uniqueservice handler:", skynet.address(us))
end)