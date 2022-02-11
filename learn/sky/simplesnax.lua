local skynet = require "skynet"
local snax = require "skynet.snax"

local i = 10
gname = "houde"


function accept.hello(...) -- 通过obj.post.hello
    skynet.error("【hello】 local i="..i..", gname="..gname, ...)
end

function accept.quit(...) -- obj.post.quit来触发回调函数
    snax.exit(...)
    -- 等同snax.kill(snax.self(), ...)
end

function response.echo(str)
    skynet.error("【echo】 ", str)  
    return str:upper()
end

function init(...) skynet.error("snax server start:", ...) end

function exit(...) skynet.error("snax server exit:", ...) end
