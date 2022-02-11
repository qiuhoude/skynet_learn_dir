

-- 设置默认值,使用公共的默认值减少内存开销
local key = {} -- 唯一的key
local mt = {__index = function (tb) return tb[key] end}

function setDefault(tb, defaultValue)
     tb[key] = defaultValue
     setmetatable(tb, mt)
end

local tb1 = {x = 10, y = 20}
print(tb1.x, tb1.z)     --> 10 nil
setDefault(tb1, 100) -->设置默认值
print(tb1.x, tb1.z) --> 10 100 这里打印的就是默认值

print("---------------------------------------")

--[[
__index 
1. 当访问一个table的字段时，如果table有这个字段，则直接返回对应的值；
2. 当table没有这个字段，则会促使解释器去查找一个叫__index的元方法，接下来就就会调用对应的元方法，返回元方法返回的值；
3. 如果没有这个元方法，那么就返回nil结果。

__newindex
1. Lua解释器先判断这个table是否有元表；
2. 如果有了元表，就查找元表中是否有__newindex元方法；如果没有元表，就直接添加这个索引，然后对应的赋值；
3. 如果有这个__newindex元方法，Lua解释器就执行它，而不是执行赋值；
4. 如果这个__newindex对应的不是一个函数，而是一个table时，Lua解释器就在这个table中执行赋值，而不是对原来的table。
]]

-- 创建元表 【记录table的访问】
local mt = {
    __index = function (t, k)
        print("access to element " .. tostring(k))
        return t[key][k]
    end,
    __newindex = function (t, k, v)
        print("update of element " .. tostring(k))
        t[key][k] = v
    end
}
 
function proxy(t)
    local p = {}
    p[key] = t
    setmetatable(p,mt)
    return p
end

local player = {
    id = 123
}
player = proxy(player)

player.x = 10 -- update of element x
print(player.x) -- access to element x
print(player.id)


print("---------------------------------------")

-- 【 只读的table】 

function readOnly(t)
    local proxy = {}

    -- 创建元表
    local mt = {
        __index = t,
        __newindex = function (t, k, v)
                error("Attempt to update a read-only table", 2)
        end
    }
    setmetatable(proxy, mt)
    return proxy
end

local tbDemo = readOnly{1, 2, 3, 4, 5}
print(tbDemo[1])
tbDemo[1] = 20