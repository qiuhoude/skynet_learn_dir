-- 利用反射来进行热更
local function hotfix(f, name_, f_)
    local i = 1
    while true do
        local name, value = debug.getupvalue(f, i)
        if name == nil then
            return false
        end
        if name == name_ then
            debug.setupvalue(f, i, f_)
            return true
        end
        i = i + 1
    end
end

local function action()
    print("raw test")
end

local function wrap_test()
    action()
end

wrap_test()
hotfix(wrap_test, 'action', function()
    print('new test')
end)
wrap_test()
