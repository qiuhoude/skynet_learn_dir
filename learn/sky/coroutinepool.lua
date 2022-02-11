local coroutine_pool = setmetatable({}, {
    __mode = "kv"
})

local function co_create(f)
    local co = table.remove(coroutine_pool)
    if co == nil then
        co = coroutine.create(function(...)
            f(...)
            while true do
                f = nil
                coroutine_pool[#coroutine_pool + 1] = co
                f = coroutine.yield "SUSPEND"
                f(coroutine.yield())
            end
        end)
    else
        coroutine.resume(co, f)
    end
    return co
end

local function fun1()
    f = io.open("/dev/null", "w")
    f:write("jjjjjjjjjjjjjj")
end

local t1 = os.time()
local m1 = collectgarbage('count')

for i = 1, 100000  do
    -- coroutine.resume(coroutine.create(fun1))    -- 不用pool
    coroutine.resume(co_create(fun1)) -- 用协程池
end

local m2 = collectgarbage('count')
local t2 = os.time()
print('diff time is ', t2 - t1)
print('diff mem is ', m2 - m1)
