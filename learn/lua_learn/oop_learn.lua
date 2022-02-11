local account = require("account")

local a = account:new()
a:deposit(100)

local b = account:new()
b:deposit(50)

print(a.balance)  --> output: 100
print(b.balance)  --> output: 50



-- 闭包形势创建对象,这样都隐藏了外部调用
function newAccount (initialBalance)
    local self = {balance = initialBalance}
    local withdraw = function (v)
        self.balance = self.balance - v
    end
    local deposit = function (v)
        self.balance = self.balance + v
    end
    local getBalance = function () return self.balance end
    return {
        withdraw = withdraw,
        deposit = deposit,
        getBalance = getBalance
    }
end

a = newAccount(100)
a.deposit(100)
print(a.getBalance()) --> 200
print(a.balance)      --> nil

print("-----------------------------------------------多继承-----")
--[[
    保存所有的父类；
指定一个搜索函数来完成搜索任务。
]]
-- 在多个父类中查找字段k
local function search(k, pParentList)
    for i = 1, #pParentList do
        local v = pParentList[i][k]
        if v then
            return v
        end
    end
end

function createClass(...)
    local c = {} -- 新类
    local parents = {...}

    -- 类在其元表中搜索方法
    setmetatable(c, {__index = function (t, k) return search(k, parents) end})

    -- 将c作为其实例的元表
    c.__index = c

    -- 为这个新类建立一个新的构造函数
    function c:new(o)
        o = o or {}
        setmetatable(o, self)
        -- self.__index = self 这里不用设置了，在上面已经设置了c.__index = c
        print("cover:new")
        return o
    end
    -- 返回新的类（原型）
    return c
end

-- 一个简单的类CA
local CA = {}
function CA:new(o)
    o = o or {}
    setmetatable(o, {__index = self})
    self.__index = self
    print("CA:new")
    return o
end

function CA:setName(strName)
    self.name = strName
end

-- 一个简单的类CB
local CB = {}
function CB:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    print("CB:new")
    return o
end

function CB:getName()
    return self.name
end



-- 创建一个c类，它的父类是CA和CB
local c = createClass(CA, CB)

-- 使用c类创建一个实例对象
local objectC = c:new{name = "Jelly"}

-- 设置objectC对象一个新的名字
objectC:setName("JellyThink")
local newName = objectC:getName()
print(newName)




