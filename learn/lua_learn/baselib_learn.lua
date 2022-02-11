

local degree = math.rad(30) -- 角度 -> 弧度 
print(math.sin(degree)) -- 0.5

print("=======")

local tb = {20, 10, 2, 3, 4, 89, 20, 33, 2, 3}

-- 默认是升序排序
table.sort(tb)
for _, v in ipairs(tb) do
    print(v)
end

print("=======")

-- 修改为降序排序
table.sort(tb, function (a, b) if a > b then return true end end)
for _, v in ipairs(tb) do
    print(v)
end

print("=======find===")
local str = "Hello12345World"
local i, j = string.find(str, "%d+")
print(i, j) -- 6   10


local str = "Hello12345World"
local subStr = string.match(str, "%d+")
print(subStr)

print("=======gsub===")
local str = "Hello World"

-- 这里不限制替换次数
local strResult, cnt = string.gsub(str, "l", "o")
print(strResult) -- Heooo Worod
print(cnt) -- 实际替换的次数

-- 开始限制替换次数
strResult, cnt = string.gsub(str, "l", "o", 1)
print(strResult) -- Heolo World
print(cnt) -- 就替换了一次

print("=======gmatch===")

local str = "Hello World"

local iteratorFunc = string.gmatch(str, "%a+") -- %a+表示匹配所有单词

for i in iteratorFunc do
    print(i)
end

-- 使用find来实现一个自己的gmatch
local myGmatch = function (s, pattern)
  local resultTb = {} -- 相当于迭代器中的恒定状态
  local index = 0 -- 相当于迭代器中的控制变量

  local i, j = string.find(s, pattern)
  while i do
    resultTb[#resultTb + 1] = string.sub(s, i, j)
    i, j = string.find(s, pattern, j + 1)
  end

  return function () -- 返回一个迭代器函数
    index = index + 1
    return resultTb[index]
  end
end

for i in myGmatch(str, "%a+") do
  print(i)
end