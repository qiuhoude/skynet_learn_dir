local skynet = require "skynet"

local function task(id)
    local handler = skynet.localname(".echoluamsg")
    for i = 1, 5 do
        skynet.error("task" .. id .. " call"..i)
        skynet.error("task" .. id .. " call"..i.." return:",
                     skynet.call(handler, "lua", "task" .. id))
    end
end

skynet.start(function()
    skynet.fork(task, 1) -- 开两个线程去执行
    skynet.fork(task, 2)
end)
