local skynet = require "skynet"
local mc = require "skynet.multicast"
local channel
local channelID = ... -- 从启动参数获取channelID
channelID = tonumber(channelID)
--  multicastpub; multicastsub 1
local function recvChannel(channel, source, msg, ...)
    skynet.error("channel ID:", channel, "source:", skynet.address(source),
                 "msg:", msg)
end

skynet.start(function()
    channel = mc.new {
        channel = channelID, -- 绑定上一个频道
        dispatch = recvChannel -- 设置这个频道的消息处理函数
    }
    channel:subscribe()
    skynet.timeout(500, function() channel:unsubscribe() end) -- 5秒钟后取消订阅
end)
