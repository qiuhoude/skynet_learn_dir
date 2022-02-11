local skynet = require "skynet"
-- 使用source服务地址，发送typename类型的消息给dest服务，不需要接收响应，（source，dest只能是服务ID）
-- msg sz一般使用skynet.pack打包生成 skynet.redirect(dest,source,typename, session, msg, sz)

local source, dest = ...
skynet.start(function()
    source = skynet.localname(source)
    dest = skynet.localname(dest)
    skynet.redirect(source, dest, "lua", 0, skynet.pack("Twitter", 8.8, false))
end)
