package.cpath = "luaclib/?.so"
package.path = "lualib/?.lua"

if _VERSION ~= "Lua 5.3" then error "Use lua 5.3" end

local socket = require "client.socket"

local fd = assert(socket.connect("127.0.0.1", 8083))

local function send_msg(msg)
    socket.send(fd, msg)
    print("send -> " .. msg)
end

send_msg("hello world~~~")

local function print_recv_msg(fd)
    while true do
        local str = socket.recv(fd)
        if str ~= nil and str ~= "" then
            print("recv <- " .. str)
            break
        end
    end
end

-- local co = coroutine.create(print_recv_msg)

-- coroutine.resume(co, fd)

while true do
    print_recv_msg(fd)
    -- 读取控制台用户输入消息
    local cmd = socket.readstdin()
    if cmd then
        if cmd == "quit" then
            socket.close(fd)
            break
        else
            send_msg(cmd)
        end
    else
        socket.usleep(100)
    end
end
