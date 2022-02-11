local skynet = require "skynet"
local mysql = require "skynet.db.mysql"

skynet.start(function()
    local function on_connect(db)
        skynet.error("on_connect")
    end
    local db=mysql.connect({
        host="192.168.1.151",
        port=3306,
        database="honor_ini",
        user="root",
        password="jeC02GfP",
        max_packet_size = 1024 * 1024,
        on_connect = on_connect
    })
    if not db then
        skynet.error("failed to connect")
    else
        skynet.error("success to connect to mysql server")    
    end
end)