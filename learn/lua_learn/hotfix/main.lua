local function Sleep(n)
    os.execute("sleep " .. n)
end

local function reload_moudle(module_name)
    -- 获取旧对象的引用
    local old_module = _G[module_name]
    package.loaded[module_name] = nil

    local new_module = require(module_name)
    for k, v in pairs(new_module) do
        old_module[k] = v
    end
    package.loaded[module_name] = old_module
end

local other = require("other")
local function main()
    -- print("berfore -> ",package.loaded["other"])

    for i = 1, 5 do
        local m2 = require("other")
        print('m2.a', m2.a)
        Sleep(2)
        -- 将require 模块设置nil,other文件中有改变也会跟着改变,优缺点,就是已经应用的版本不能得到更新
        -- package.loaded["other"] = nil 
        -- 改进版本
        reload_moudle("other")
    end
    -- print("after -> ",package.loaded["other"])
    print('----> other.a', other.a) -- 如果直接 package.loaded["other"] = nil m1.a的值依然是旧的
end

-- main()

function getfield(f)
    local v = _G -- 从全局变量的table开始
    
    for w in string.gmatch(f, "[%w_]+") do
        v = v[w]
    end
    return v
end

function setfield(f, v)
    local t = _G -- 从全局变量的table开始
    
    for w, d in string.gmatch(f, "([%w_]+)(%.?)") do
        if d == '.' then
            t[w] = t[w] or {}
            t = t[w]
        else
            t[w] = v
        end
    end
    return t
end


-- local v = getfield("os")
-- print("")
-- v.execute("echo hi")

-- setfield("t.x.y", 10)
-- print(t.x.y)  
-- print(getfield("t.x.y"))




local function myfun()
    local a = 10
    local info = debug.getinfo(1)
    for k, v in pairs(info) do
        print(string.format('%20s: %s', k, v))
    end
end

local name, val
local function myfun2(var)
    local a = 10
    local index = 1
    g = 108
    repeat
        name, val = debug.getlocal(1, index)
        print(index, name, val)
        index = index + 1
    until not name
end
-- myfun()
myfun2(100)