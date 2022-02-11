local skynet = require "skynet"
local mc = require "skynet.multicast"

local channel

function task()
    for i = 1, 100 do
        skynet.sleep(100)
        channel:publish("data" .. i) -- 推送数据到channel中
    end
    channel.delete() -- 让系统回收频道
    skynet.exit()
end

skynet.start(function()
    channel = mc.new()
    skynet.error("new channel ID", channel.channel)
    skynet.fork(task)
end)
