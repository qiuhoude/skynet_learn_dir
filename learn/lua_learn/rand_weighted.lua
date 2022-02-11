local function prepare_weighted_random4(values, weights)
    assert(#values == #weights)
    local tinsert = table.insert
    local ipairs = ipairs

    local count = #weights
    local sum = 0       -- 计算总和
    for _, w in ipairs(weights) do
        sum = sum + w
    end
    local avg = sum / count     -- 平均权重
    
    print("avg",avg)

    local aliases = {}      -- 别名表
    for _, _ in ipairs(weights) do
        tinsert(aliases, {1, false})
    end

    local sidx = 1  -- 找到第1个小于平均值的索引
    while sidx <= count and weights[sidx] >= avg do
        sidx = sidx + 1
    end
    if sidx <= count then   -- 如果 small_i > count 表示所有权重值相等，什么也不用处理
        local small = {sidx, weights[sidx] / avg}
        local bidx = 1      -- 找到第1个大于等于平均值的索引
        while bidx <= count and weights[bidx] < avg do
            bidx = bidx + 1
        end
        local big = {bidx, weights[bidx] / avg}

        while true do
            aliases[small[1]] = {small[2], big[1]}  -- 桶的索引即是小权重的索引，从中去掉小权重的比例，剩余的放大权重
            print(string.format("small[1]=%s small[2]=%s big[1]=%s big[2]=%s",small[1],small[2],big[1],big[2]))
            big = {big[1], big[2] - (1-small[2])}   -- 大权重去掉已放入的比例
            
            if big[2] < 1 then  -- 如果大权重剩余的比例已小于1，表示小于平均权重
                small = big     -- 大权重变成小权重
                bidx = bidx + 1 -- 找下一个大权重的索引
                while bidx <= count and weights[bidx] < avg do
                    bidx = bidx + 1
                end
                if bidx > count then
                    break
                end
                big = {bidx, weights[bidx] / avg} -- 得到下一个大权重
            else    -- 大权重的比例大于等于1，表示不比平均权重小，继续找小权重
                sidx = sidx + 1     -- 找下一个小权重索引
                while sidx <= count and weights[sidx] >= avg do
                    sidx = sidx + 1
                end
                if sidx > count then
                    break
                end
                small = {sidx, weights[sidx] / avg}
            end
        end
    end
    for i, v in ipairs(aliases) do
        print(string.format("%s: %s %s", i,v[1],v[2]))
    end


    return function()
        local n = math.random() * count
        local i = math.floor(n)
        local odds, alias = aliases[i+1][1], aliases[i+1][2]    -- 小权重比例，大权重索引
      
        local idx
        if n - i > odds then
            idx =  alias
        else
            idx = i + 1
        end
        print(string.format("count=%s n=%s i=%s odds=%s alias=%s idx=%s", count ,n,i,odds,alias,idx))

        return values[idx], weights[idx]
    end
end


local function benchmarks()
    local values = {}
    local weights = {}
    for i = 1, 5 do
        values[i] = i
        weights[i] = math.random(1, 1000)
    end

    local randomizers = {
        -- {"Linear Scan", prepare_weighted_random1(values, weights)},
        -- {"Binary Search", prepare_weighted_random2(values, weights)},
        -- {"Hopscotch Selection", prepare_weighted_random3(values, weights)},
        {"Alias Method ", prepare_weighted_random4(values, weights)},
    }

    for _, randomizer in ipairs(randomizers) do
        local tm = os.clock()
        for i = 1, 1 do
            randomizer[2]()
        end
        print(string.format("%s time = %s", randomizer[1], os.clock() - tm))
    end
end
benchmarks()
