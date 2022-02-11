package.cpath = "luaclib/?.so"

local socket = require "client.socket"
local crypt = require "client.crypt"

if _VERSION ~= "Lua 5.3" then
	error "Use lua 5.3"
end

-- ./3rd/lua/lua ./learn/myloginclient.lua 

local fd = assert(socket.connect("127.0.0.1", 8001))

local function writeline(fd, text)
	socket.send(fd, text .. "\n")
end

local function unpack_line(text)
	local from = text:find("\n", 1, true) -- 按照每行解析
	if from then
		return text:sub(1, from-1), text:sub(from+1)
	end
	return nil, text
end

local last = ""

local function unpack_f(f)
	local function try_recv(fd, last)
		local result
		result, last = f(last)
		if result then
			return result, last
		end
		local r = socket.recv(fd)
		if not r then
			return nil, last
		end
		if r == "" then
			error "Server closed"
		end
		return f(last .. r)
	end

	return function()
		while true do
			local result
			result, last = try_recv(fd, last)
			if result then
				return result
			end
			socket.usleep(100)
		end
	end
end






print("----------handshake start")
------ handshake start
local readline = unpack_f(unpack_line)

local challenge = crypt.base64decode(readline())
local clientkey = crypt.randomkey()
--把clientkey换算后比如称它为ckeys，发给服务器
writeline(fd, crypt.base64encode(crypt.dhexchange(clientkey)))
--服务器也把serverkey换算后比如称它为skeys，发给客户端，客户端用clientkey与skeys所出secret
local skeys = crypt.base64decode(readline())
local secret = crypt.dhsecret(skeys, clientkey)

print("sceret is ", crypt.hexencode(secret))

local hmac = crypt.hmac64(challenge, secret)
writeline(fd, crypt.base64encode(hmac))     -- hmac64(challenge, secret)发给服务端进行校验生成的 secret

------ handshake end  
print("----------handshake end")

local token = {
	server = "sample",
	user = "houde",
	pass = "password",
}

local function encode_token(token)
	return string.format("%s@%s:%s",
		crypt.base64encode(token.user),
		crypt.base64encode(token.server),
		crypt.base64encode(token.pass))
end

-- --使用DES加密token得到etoken, etoken是字节流
local etoken = crypt.desencode(secret, encode_token(token))
local b = crypt.base64encode(etoken)
--发送etoken，服务端将会调用auth_handler回调函数, 以及login_handler回调函数。
writeline(fd, b)


local result = readline() -- 读取最后结果
print("last result=",result)
local code = tonumber(string.sub(result, 1, 3))
assert(code == 200, "code is not 200 result is "..result)
socket.close(fd)

local subid = crypt.base64decode(string.sub(result, 5)) --解析出subid
print("login ok, subid=", subid)
