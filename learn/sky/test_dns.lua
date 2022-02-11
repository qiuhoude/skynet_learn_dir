local skynet = require "skynet"
local dns = require "skynet.dns"

-- test_dns
skynet.start(function()
    skynet.error("nameserver:", dns.server())   --设置DNS服务器地址
    -- you can specify the server like dns.server("8.8.4.4", 53)
    
    local ip, ips = dns.resolve("github.com")  --调用成功，则把结果缓存到这个服务的内存中，便于下次使用
    skynet.error("dns.resolve return:", ip)
    
    for k,v in ipairs(ips) do
        skynet.error("github.com",v)
    end
    dns.flush()
end)