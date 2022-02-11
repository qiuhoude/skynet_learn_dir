-- local Object = {a = 123} -- 如果改成 {a={b=123}},就会出现 创建的对象后子类会改变父类的值
local Object = {
    a = {
        b = 123
    }
}
function Object:new(data)
    local data = data or {}
    setmetatable(data, {
        __index = self
    })
    return data
end

local o = Object:new()

-- o.a = 456
-- print("o.a =>",o.a,"; Object.a =>",Object.a)

print("o.a.b =>", o.a.b)
o.a.b = 456
print("o.a.b =>", o.a.b, "; Object.a.b =>", Object.a.b) -- Object.a.b 变成 456

-- 深度拷贝
local function deepcopy(t, nometa)
    local lookup_table = {}
    local function _copy(t, nometa)
        if type(t) ~= "table" then
            return t
        elseif lookup_table[t] then
            return lookup_table[t]
        end
        local new_table = {}
        lookup_table[t] = new_table
        for index, value in pairs(t) do
            new_table[_copy(index)] = _copy(value)
        end
        if not nometa then
            new_table = setmetatable(new_table, getmetatable(t))
        end
        return new_table
    end
    return _copy(t)
end

function Object:new2(data)
    data = data or {}
    local copy = deepcopy(self)
    setmetatable(data, {
        __index = copy
    })
    return data
end

function func1()
    return 1, 2
end
function func2()
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
 