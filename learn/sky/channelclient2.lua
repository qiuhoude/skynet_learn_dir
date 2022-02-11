local skynet = require "skynet"
require "skynet.manager"
local sc = require "skynet.socketchannel"

--[[ 
     在模式 2 下，channel.request 的参数有所变化。第 2 个参数不再是 response 函数（它已经在创建时给出），
 ]]
-- serverreadline channelclient2

local function dispatch(sock)
    local r = sock:read()
    print("dispatch r:", r)
    local session = tonumber(string.sub(r, 6))
    -- 返回值必须要有三个，第一个session
    return session, true, r
end

local channel = sc.channel {
    host = "127.0.0.1",
    port = 8083,
    response = dispatch -- 处理消息的函数

}

local function task()
    local resp
    for i = 1, 3 do
        skynet.fork(function(session)
            resp = channel:request("data_" .. session .. "\n",session)
            skynet.error("recv-> resp:", resp, " session:", session)
        end, i)
    end
    -- channel:close()   --channel可以不用关闭，当前服务退出的时候会自动关闭掉 gc 会回收 channel 占用的资源
end

skynet.start(function() skynet.fork(task) end)
