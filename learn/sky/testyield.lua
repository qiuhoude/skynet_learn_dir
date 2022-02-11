local skynet = require "skynet"

function task(name)
    local i = 0
    skynet.error(name, "begin task")
    while (i < 200000000) do
        i = i + 1
        if i % 50000000 == 0 then
            skynet.yield()
            skynet.error(name, "task yield")
        end
    end
    skynet.error(name, "end task", i)
end

skynet.start(function()
    skynet.fork(task, "task1")
    skynet.fork(task, "task2")
end)
