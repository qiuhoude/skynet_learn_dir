local utils = {}

function utils.print_args(...)
    local args = {...}
    for k, v in pairs(args) do print("arg" .. k .. ":", v) end
end

return utils
