local skynet = require "skynet" 

local cmd,domain = ...

-- testdnsservice getip www.google.com
function task()
    local r, ips = skynet.call(".dnsservice", "lua", cmd, domain)
    skynet.error("dnsservice Test:", domain, r)
    skynet.exit()
end

skynet.start(function()
    skynet.fork(task)
end)