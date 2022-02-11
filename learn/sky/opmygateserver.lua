local skynet = require "skynet"


-- opmygateserver :01000012 kick 11
-- opmygateserver :01000012 close
local gateserver,fd,cmd = ...

fd = tonumber(fd) --必须要转换成整形数，skynet命令行传入的参数都是字符串
skynet.start(function()
    skynet.call(gateserver, "lua",  cmd, fd)
    skynet.exit()
end)