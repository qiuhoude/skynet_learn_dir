-- socket的例子

local skynet = require "skynet"
local socket = require "skynet.socket"


-- 读取客户端数据, 并输出
local function echo( id )
    --[[ 
        每当 accept 函数获得一个新的 socket id 后，并不会立即收到这个 socket 上的数据。这是因为，
        我们有时会希望把这个 socket 的操作权转让给别的服务去处理。

        socket 的 id 对于整个 skynet 节点都是公开的。也就是说，你可以把 id
         这个数字通过消息发送给其它服务，其他服务也可以去操作它。任何一个服务只有在调用 socket.start(id) 之后，
         才可以收到这个 socket 上的数据。skynet 框架是根据调用 start 这个 api 的位置来决定把对应 socket 上的数据转发到哪里去的。

        向一个 socket id 写数据也需要先调用 start ，但写数据不限制在调用 start 的同一个服务中。也就是说，
        你可以在一个服务中调用 start ，然后在另一个服务中向其写入数据。skynet 可以保证一次 write 调用的原子性。
        即，如果你有多个服务同时向一个 socket id 写数据，每个写操作的串不会被分割开。
     ]]
    socket.start(id)
    while true do
        local str = socket.read(id)
        if str then
            print("clinet -> " .. str)
            local res = "~!~` <- "..str
            socket.write(id,res)
        else
            socket.close(id)
            break
        end
    end
end


skynet.start(function ()
    print("============== mysocket start ============")

    -- 监听一个端口，返回一个 id ，供 start 使用。
	local id = socket.listen("127.0.0.1", 8888)
	print("Listen socket :".."127.0.0.1", 8888)

	socket.start(id , function(id, addr)
			-- 接收到客户端连接或发送消息()
			print("connect from " .. addr .. " " .. id)
			-- 处理接收到的消息
			echo(id)
        end)

    skynet.register "SOCKET1"
end)