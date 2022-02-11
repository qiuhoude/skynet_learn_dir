local skynet = require "skynet"

require "skynet.manager"

local global_map = {}

local command = {}

function command.get(k)
    skynet.trace("k -> "..k)
    return global_map[k]
end

function command.set(k , v)
    skynet.trace("k -> "..k..", v -> "..v)
    global_map[k] = v
    local last = global_map[k]
    return last
end

skynet.start(function ()
    print("========= houde server started==========")
    -- 这里可以编写服务代码，使用skynet.dispatch消息分发到各个服务处理函数, 就是receive函数
    skynet.dispatch("lua",function (session,address,cmd, ...)
        skynet.error("======dispatch=====")
        local f = command[cmd]
		if f then
			-- 回应一个消息可以使用 skynet.ret(message, size) 。
			-- 它会将 message size 对应的消息附上当前消息的 session ，以及 skynet.PTYPE_RESPONSE 这个类别，发送给当前消息的来源 source
			skynet.ret(skynet.pack(f(...))) --回应消息
		else
			error(string.format("Unknown command %s", tostring(cmd)))
		end
	end)
	--可以为自己注册一个别名。（别名必须在 32 个字符以内）
	skynet.register "HOUDE_DB"
end)