local skynet = require "skynet"
local snax = require "skynet.snax"
-- testhotfix

skynet.start(function ()
    local obj = snax.newservice("simplesnax") --启动simplessnax服务
    skynet.error("snax service", obj, "startup")

    obj.post.hello()  --未更新之前调用一次

    -- snax.hotfix(obj, patchcode) 来向 obj 提交一个 patch 
    -- patch 中可以包含一个 function hotfix(...) 函数，在 patch 提交后立刻执行
    local r = snax.hotfix(obj, [[
        local i
        local skynet

        function accept.hello(...)
            -- print("fix hello", i, gname, ...) --skynet.error不能用了
            skynet.error("【fix hello】", i, gname, ...)
        end
       
        function hotfix(...)
            local tmp = i
            i = 101
            return tmp
        end
        ]])

    skynet.error("hotfix return:", r) -- r就是 patch 中hotfix的值
    obj.post.hello() --更新之后再调用一次
    obj.post.quit() --没更新quit函数，还是能调用
    skynet.exit()

end)