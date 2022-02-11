local login = require "snax.loginserver"
local crypt = require "skynet.crypt"
local skynet = require "skynet"


-- myloginserver 

-- 会起多个服务 轮流处理登陆请求

local server = {
	host = "127.0.0.1",
	port = 8001,
	--[[
		multilogin设置为false表示不允许同时重复登录，
		这里的同时重复登录不是说一个client登录完成之后，
		另一个client端使用相同的账号密码就不能登录。而是说在登录过程当中，还没完成登录，
		这个时候突然又有一个client尝试登录。那么会报给这个客户端406 Not Acceptable 
	]]
	multilogin = false,	-- disallow multilogin
	name = "login_master",
}


--[[
你需要实现这个方法，对一个客户端发送过来的 token 做验证。
如果验证不能通过，可以通过 error 抛出异常。如果验证通过，
需要返回用户希望进入的登陆点以及用户名。
（登陆点可以是包含在 token 内由用户自行决定,也可以在这里实现一个负载均衡器来选择）
]]
function server.auth_handler(token)
    -- the token is base64(user)@base64(server):base64(password)
    local user, server, password = token:match("([^@]+)@([^:]+):(.+)")
	user = crypt.base64decode(user)
	server = crypt.base64decode(server)
    password = crypt.base64decode(password)
     -- 密码不对直接报错中断当前协程，千万不要返回nil值
     --，一定要用assert中断或者error报错终止掉当前协程
	assert(password == "password", "Invalid password")
	return server, user
end


-- local server_list = {}
-- local user_online = {}
-- local user_login = {}

local subid = 0

function server.login_handler(server, uid, secret)
	print(string.format("%s@%s is login, secret is %s", uid, server, crypt.hexencode(secret)))
    subid = subid + 1
	-- error("就是想再这里报个错")
	-- skynet.sleep(1000) -- 加delay 模拟多用户同时登陆
    return subid
end


local CMD = {}

function CMD.register_gate(server, address)
    skynet.error("cmd register_gate")
end

--实现command_handler，必须要实现，用来处理lua消息
function server.command_handler(command, ...)
	local f = assert(CMD[command])
	return f(...)
end

login(server)