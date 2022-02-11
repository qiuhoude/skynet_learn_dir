package.cpath = "luaclib/?.so"
package.path = "lualib/?.lua;houde/?.lua"

if _VERSION ~= "Lua 5.3" then
	error "Use lua 5.3"
end

local socket = require "client.socket"
-- 通信协议
local proto = require "proto"
local sproto = require "sproto"


local host = sproto.new(proto.s2c):host "package"

--[[ attach 可以构造一个发送函数，用来将对外请求打包编码成可以被 dispatch 正确解码的数据包。 ]]
local request = host:attach(sproto.new(proto.c2s))

local fd = assert(socket.connect("127.0.0.1", 8888))


local session = 0

local function send_request( name, args )
	-- session = session + 1
	local str = request(name,args,session)
	socket.send(fd, str)
	print("Request:", session)
end

send_request("handshake")
send_request("say",{name = "houde", msg = "hi~~~~~~~~~~"})

while true do
	-- 接收服务器返回消息
	local str  = socket.recv(fd)
	if str~=nil and str~="" then
        print("recv -> "..str)
    end

	-- 读取控制台用户输入消息
	local readstr = socket.readstdin()
	if readstr then
		if readstr == "quit" then
			socket.close(fd)
			break;
		else
			send_request("say",{name = "houde", msg = readstr})
		end
	else
		socket.usleep(100)
	end
end