Set = {}
local mt = {} -- 集合的元表

-- 根据参数列表中的值创建一个新的集合
function Set.new(l)
     local set = {}
     setmetatable(set, mt)
     for _, v in pairs(l) do set[v] = true end
     mt.__metatable = "You cannot get the metatable" -- 设置完的元表以后，不让其他人再设置
     return set
end

-- 并集操作
function Set.union(a, b)
    local retSet = Set.new{} -- 此处相当于Set.new({})
    for v in pairs(a) do retSet[v] = true end
    for v in pairs(b) do retSet[v] = true end
    return retSet
end

-- 交集操作
function Set.intersection(a, b)
    local retSet = Set.new{}
    for v in pairs(a) do retSet[v] = b[v] end
    return retSet
end

-- 打印集合的操作
function Set.tostring(set)
     local tb = {}
     for e in pairs(set) do
          tb[#tb + 1] = e
     end
     return "{" .. table.concat(tb, ", ") .. "}"
end

function Set.print(s)
     print(Set.toString(s))
end

mt.__add = Set.union
mt.__tostring  = Set.toString

-- test set
local set1 = Set.new({10, 20, 30})
local set2 = Set.new({1, 2})
print(getmetatable(set1)) -- 获取的都是同一个 matetable
print(getmetatable(set2))
assert(getmetatable(set1) == getmetatable(set2))

local set12= set1 + set2
print("set1 + set2: ",Set.tostring(set12))


-----------------------

--[[
print_dump是一个用于调试输出数据的函数，能够打印出nil,boolean,number,string,table类型的数据，以及table类型值的元表
参数data表示要输出的数据
参数showMetatable表示是否要输出元表
参数lastCount用于格式控制，用户请勿使用该变量
]]

function print_dump(data, showMetatable, lastCount)
     if type(data) ~= "table" then
         --Value
         if type(data) == "string" then
             io.write("\"", data, "\"")
         else
             io.write(tostring(data))
         end
     else
         --Format
         local count = lastCount or 0
         count = count + 1
         io.write("{\n")
         --Metatable
         if showMetatable then
             for i = 1,count do io.write("\t") end
             local mt = getmetatable(data)
             io.write("\"__metatable\" = ")
             print_dump(mt, showMetatable, count)    -- 如果不想看到元表的元表，可将showMetatable处填nil
             io.write(",\n")     --如果不想在元表后加逗号，可以删除这里的逗号
         end
         --Key
         for key,value in pairs(data) do
             for i = 1,count do io.write("\t") end
             if type(key) == "string" then
                 io.write("\"", key, "\" = ")
             elseif type(key) == "number" then
                 io.write("[", key, "] = ")
             else
                 io.write(tostring(key))
             end
             print_dump(value, showMetatable, count) -- 如果不想看到子table的元表，可将showMetatable处填nil
             io.write(",\n")     --如果不想在table的每一个item后加逗号，可以删除这里的逗号
         end
         --Format
         for i = 1,lastCount or 0 do io.write("\t") end
         io.write("}")
     end
     --Format
     if not lastCount then
         io.write("\n")
     end
 end

t1 = {}
tm = {}
db = {k=1}
tm.__newindex = db
setmetatable(t1,tm)
print_dump(t1,true)
t1.k2 = 2
print_dump(t1,true)