local coCunsume = coroutine.create(function(filter, producer)
    while true do
        local stutas, msg = coroutine.resume(filter, producer)
        if not stutas then
            break
        end
        print(msg)
    end
end)

local coFilter = coroutine.create(function(producer)
    while true do
        local stutas, msg = coroutine.resume(producer)
        if not stutas then
            break
        end
        coroutine.yield(msg)
    end
end)

local function sleep(n)
    os.execute("sleep " .. n)
end

math.randomseed(os.time())
local coProducer = coroutine.create(function()
    for i = 1, 10 do
        local s = math.random(0, 3)
        sleep(s)
        local msg = i .. ": " .. s
        coroutine.yield(msg)
    end
end)

coroutine.resume(coCunsume, coFilter, coProducer)

-- 
-- local s = math.random(0, 3)
-- sleep(s)

-- for i = 1, 10 do
-- print(i) 
-- end
