local skynet = require "skynet"
require "skynet.manager"	-- import skynet.register
local socket = require "skynet.socket"

local sproto = require "sproto"


local proto = require "proto"

local host

local REQUEST = {}

function REQUEST:say()
	print("say -> ", self.name, self.msg)
end


function REQUEST:handshake()
	print("handshake~~~~~~~~~~~")
end

function REQUEST:quit()
	print("quit~~~~~~")
end

local function request(name, args, response)
	local f = assert(REQUEST[name])
	local r = f(args)
	if response then
		-- 生成回应包(response是一个用于生成回应包的函数。)
		-- 处理session对应问题
		return response(r)
	end
end

local function send_package(fd,pack)
	-- 协议与客户端对应(两字节长度包头+内容)
	local package = string.pack(">s2", pack)
	socket.write(fd, package)
end

local function accept(id)
	-- 每当 accept 函数获得一个新的 socket id 后，并不会立即收到这个 socket 上的数据。这是因为，我们有时会希望把这个 socket 的操作权转让给别的服务去处理。
    -- 任何一个服务只有在调用 socket.start(id) 之后，才可以收到这个 socket 上的数据。
	socket.start(id)

	host = sproto.new(proto.c2s):host "package"
	-- request = host:attach(sproto.new(proto.c2s))

	while true do
		local str = socket.read(id)
		if str then
			
			-- REQUEST : 第一个返回值为 "REQUEST" 时，表示这是一个远程请求。如果请求包中没有 session 字段，
			-- 表示该请求不需要回应。这时，第 2 和第 3 个返回值分别为消息类型名（即在 sproto 定义中提到的某个以 . 开头的类型名），
			-- 以及消息内容（通常是一个 table ）；如果请求包中有 session 字段，那么还会有第 4 个返回值：一个用于生成回应包的函数。
			local type,str2,str3,str4 = host:dispatch(str)
			print(string.format( "type=%s, str2=%s, str3=%s, str4=%s",type,str2,str3,str4))
			if type=="REQUEST" then
				local ok, result  = pcall(request, str2,str3,str4)
				if ok then
					if result then
						socket.write(id, "收到了")
					end
				else
					skynet.error(result)
				end
			end

			if type=="RESPONSE" then
				-- RESPONSE ：第一个返回值为 "RESPONSE" 时，第 2 和 第 3 个返回值分别为 session 和消息内容。消息内容通常是一个 table ，但也可能不存在内容（仅仅是一个回应确认）。
				-- 暂时不处理客户端的回应
				print("client response")
			end

		else
			socket.close(id)
			return
		end
	end
end

skynet.start(function()
	print("==========Socket2 Start=========")
	local id = socket.listen("127.0.0.1", 8888)
	print("Listen socket :", "127.0.0.1", 8888)

	socket.start(id , function(id, addr)
			-- 接收到客户端连接或发送消息()
			print("connect from " .. addr .. " " .. id)

			-- 处理接收到的消息
			accept(id)
		end)
	--可以为自己注册一个别名。（别名必须在 32 个字符以内）
	skynet.register "SOCKET2"
end)