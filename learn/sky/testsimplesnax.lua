local skynet = require "skynet"
local snax = require "skynet.snax"

-- testsimplesnax
skynet.start(function()

    --[[ 
        --无响应请求，obj是snax对象，post表示无响应请求，CMD具体的请求命令，...为请求参数列表，发送完马上返回
obj.post.CMD(...)
--有响应请求，obj是snax对象，req表示有响应请求，CMD具体的请求命令，...为请求参数列表，发送完等待响应
obj.req.CMD(...)
     ]]
    local obj = snax.uniqueservice("simplesnax", 123, "abc", false) -- 启动simplessnax服务,并传递参数
    skynet.error("snax service", obj, "startup")

    obj = snax.queryservice("simplesnax") --查询全局唯一服
    snax.kill(obj, 123, "abc")

    local gobj = snax.globalservice("simplesnax", 123, "abc") --启动simplessnax服务
    gobj = snax.queryglobal("simplesnax") --查询全节点全局唯一服
    snax.kill(gobj, 123, "abc")

    
    -- local r = obj.post.hello(123, "abc", false) -- 调用simplesnax中的accept.hello方法
    -- skynet.error("hello return:", r)

    -- local r2 = obj.req.echo("houde") --调用simplesnax中的response.echo方法
    -- skynet.error("echo return:", r2)
    -- obj.post.quit("exit now") -- 退出服务

    skynet.exit()
end)
