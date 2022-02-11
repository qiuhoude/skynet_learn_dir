


function print_G()
    local i = 1
    for k,v in pairs(_G) do 
        print(i,k,v)
        i = i + 1 
    end
end

--[[

-- 禁止修改_G
setmetatable(_G, {
    __newindex = function (_, k)
         error("Attempt to write to undeclared variable " .. k)
    end,
    __index = function (_, k)
         error("Attempt to read undeclared variable " .. k)
    end
})

]]

name___ = 1 -- 创建了 全局的变量 name___ 可以再_G中查找到
print_G()