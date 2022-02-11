local skynet = require "skynet"
local dns = require "skynet.dns"
require "skynet.manager"
-- dnsservice
local command  = {}

function command.FLUSH()
    return dns.flush()
end



function command.GETIP(domain)
   return dns.resolve(domain)
end


skynet.start(function() 
    --  port 的默认值为 53 。如果不填写 ip 的话，将从 /etc/resolv.conf 中找到合适的 ip
    dns.server()

    skynet.dispatch("lua",function(session,address,cmd,...) 
        cmd = cmd:upper()
        local f = command[cmd]
        if f then
            skynet.retpack(f(...))
        else 
            skynet.error(string.format("Unknown command %s", tostring(cmd)))
        end
    end)

    skynet.register ".dnsservice" 
end)