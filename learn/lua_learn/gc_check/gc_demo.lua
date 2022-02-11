local function test1()
    collectgarbage("collect") -- 先清理一次
    -- "count": 以 K 字节数为单位返回 Lua 使用的总内存数。 这个值有小数部分，所以只需要乘上 1024 就能得到 Lua 使用的准确字节数（除非溢出）。
    local c1 = collectgarbage("count")
    print("t1 memory:", c1)
    -- collen 插入 50000个对象
    local collen = {} -- 将local去掉, 会导致内存泄漏
    for i = 1, 50000 do
        table.insert(collen, {})
    end
    local c2 = collectgarbage("count")
    print("t2 memory:", c2)
end

local function mem()
    local c1 = collectgarbage("count")
    print("gc before:", c1)
    print("gc...")
    collectgarbage("collect")
    local c2 = collectgarbage("count")
    print("gc after:", c2)
end

local function main()
    test1()
    mem()
end

main()
