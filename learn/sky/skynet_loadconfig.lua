
require("LuaPanda").start("127.0.0.1", 8818);

local result = {}

local function getenv(name)
    return assert(os.getenv(name), [[os.getenv() failed: ]] .. name)
end
local sep = package.config:sub(1, 1)
local current_path = [[.]] .. sep

print("1-> ", sep, current_path)

local function include(filename)
    local last_path = current_path
    local path, name = filename:match([[(.*]] .. sep .. [[)(.*)$]]) -- (.*/)(.*)

    if path then
        if path:sub(1, 1) == sep then -- root
            current_path = path
        else
            current_path = current_path .. path
        end
    else
        name = filename
    end
    print("2-> ", filename, path, name)

    local f = assert(io.open(current_path .. name))
    local code = assert(f:read [[*a]])
    print("3-> ", code)
    code = string.gsub(code, [[%$([%w_%d]+)]], getenv)
    print("4-> ", code)

    f:close()
    assert(load(code, [[@]] .. filename, [[t]], result))()
    print("5->", current_path)
    current_path = last_path
end

setmetatable(result, {
    __index = {
        include = include
    }
})
local config_name = ...
include(config_name)
setmetatable(result, nil)

-- return result
