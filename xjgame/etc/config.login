thread = 8
logger = nil
harbor = 0
bootstrap = "snlua bootstrap"	-- The service for bootstrap
lualoader = "lualib/loader.lua"
cpath = "./cservice/?.so"
cluster = "./xjgame/etc/clustername.lua"
luaservice = "./service/?.lua;./xjgame/?.lua;./xjgame/etc/?.lua;./xjgame/login/?.lua;./xjgame/lualib/?.lua;./xjgame/proto/?.lua;./xjgame/service/?.lua;./xjgame/game/?.lua"
lua_path = "./lualib/?.lua;./xjgame/?.lua;./xjgame/etc/?.lua;./xjgame/login/?.lua;./xjgame/lualib/?.lua;./xjgame/proto/?.lua;./xjgame/service/?.lua;./xjgame/game/?.lua"
lua_cpath = "./cservice/?.so;./luaclib/?.so;./xjgame/luaclib/?.so"
runconfig = "runconfig"
serverid  = 1

start = "main"  
harborname = "login"
 