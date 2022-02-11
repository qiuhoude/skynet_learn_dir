-- 尽量不要在返回值中使用table
local function testRetTable()
    print("---------------test testRetTable---------------")

    local function func1()
        return 1, 2
    end

    local function func2()
        return {
            a = 1,
            b = 2
        }
    end

    local count = 20000000
    local t1 = os.time()
    for i = 1, count do
        local a, b = func1()
    end
    local t2 = os.time()
    print("func1 time ->", os.difftime(t2, t1))

    for i = 1, count do
        local a, b = func2()
    end
    print("func2 time ->", os.difftime(os.time(), t2))
end

-- 不要使用字符串作为比较对象
local function testEqStr()
    print("---------------test testEqStr---------------")

    local function func3(param)
        if param == 1 then
            return 1
        elseif param == 2 then
            return 2
        end
    end
    local function func4(param)
        if param == 'test_first' then
            return 1
        elseif param == 'test_two' then
            return 2
        end
    end
    local count = 20000000
    local function test3()
        for i = 1, count do
            local p = 1
            local a = func3(p)
        end
    end

    local function test4()
        for i = 1, count do
            local p = 'test_first'
            local a = func4(p)
        end
    end

    local t1 = os.time()
    test3()
    local t2 = os.time()

    print("func3 time ->", os.difftime(t2, t1))
    test4()
    print("func4 time ->", os.difftime(os.time(), t2))
end

-- testRetTable()
-- testEqStr()

local g = {
    c = 5
}

local obj = {}
print("obj ", obj)
local obj2 = setmetatable(obj, {
    __index = function(t, k)
        print("index _>", t, k)
        return k
    end
})
print("obj2", obj2)
print(obj2.c)
