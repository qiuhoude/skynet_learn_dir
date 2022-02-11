

--[[
泛型for比较复杂，它在循环过程内保存了迭代器函数。它实际上保存着3个值：一个迭代器函数、一个恒定状态和一个控制变量
语法:

for <var-list> in <exp-list> do
     <body>
end

<var-list>是一个或多个变量名的列表，以逗号分隔；
<exp-list>是一个或多个表达式的列表，同样以逗号分隔。通常表达式列表只有一个元素，即一句对迭代器函数的调用。例如：
`for k, v in pairs(t) do print(k, v) end`

for做的第一件事就是对in后面的表达式求值，这些表达式应该返回3个值供for保存：迭代器函数、恒定状态和控制变量的初值
只有最后一个表达式才会产生多个结果，并且只会保留前3个值，多余的值会被丢弃


for var_1, ..., var_n in <explist> do <block> end -- 就等价于以下代码：
do
     local _f, _s, _var = <explist>    -- 返回迭代器函数、恒定状态和控制变量的初值
     while true do
          local var_1, ..., var_n = _f(_s, _var)
          _var = var_1
          if _var == nil then break end
          <block>
          end
     end
end


ipairs是无状态的迭代器，就是一种自身不保存任何状态的迭代器。因此，我们可以在多个循环中使用同一个无状态的迭代器，避免创建新的闭包的开销。

ipairs的类比代码
local function iter(a, i)
     i = i + 1
     local v = a[i]
     if v then  -- 所以遇到nil就跳出,也ipairs的key也只能是数字
          return i, v
     end
end

function ipairs(a)
     return iter, a, 0
end


a
pairs 类比代码 next是 基础函数 运行程序来遍历表中的所有域。 第一个参数是要遍历的表，第二个参数是表中的某个键
function pairs(a)
     return next, a, nil
end

]]


function values(tb)
    local i = 0
    return function ()
         i = i + 1
         return tb[i]
    end
end

local testTb = {10, 20, 30}
for value in values(testTb) do
    print(value)
end