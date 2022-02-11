local skynet = require "skynet"
local gateserver = require "snax.gateserver"
--使用netpack进行解包
local netpack = require "skynet.netpack"


 --必须提供一张表，表里面定义connect、message等相关回调函数
local handler = {}
local CMD = {} -- 存储命令
local agents = {} -- 存储agent使用

skynet.register_protocol {
    name = "client",
    id = skynet.PTYPE_CLIENT
}


--当一个客户端链接进来，gateserver自动处理链接，并且调用该函数，必须要有
function handler.connect(fd, ipaddr)   
    skynet.error("ipaddr:",ipaddr,"fd:",fd,"connect")
    gateserver.openclient(fd) --链接成功不代表马上可以读到数据，需要打开这个套接字，允许fd接收数据
    -- 连接成功后，启动 myagent服务
    local agent = skynet.newservice("myagent", fd) --连接成功就启动一个agent来代理
    agents[fd] = agent
end


--当一个客户端断开链接后调用该函数，必须要有
function handler.disconnect(fd)   
    skynet.error("fd:", fd, "disconnect")
    local agent = agents[fd]
    if agent then
        skynet.send(agent,"lua","quit")
        agents[fd] = nil -- 置空
    end
end

function handler.open(source, conf) 
    skynet.error("open -> source:", source, " conf:",conf)
    skynet.error("open by ", skynet.address(source))
    skynet.error("listen on", conf.port)
    skynet.error("client max", conf.maxclient)
    skynet.error("nodelay", conf.nodelay)
end

function handler.message(fd, msg, sz) 
    skynet.error("message -> fd:", fd, " msg:",msg," sz:",sz)
    --  msg,sz 转换成一个 lua string，并释放 msg 占用的 C 内存。
    skynet.error("unpack msg:",netpack.tostring(msg,sz) )
    local agent = agents[fd]
    if agent then
        skynet.redirect(agent, 0, "client", 0, msg, sz)  --收到消息就转发给agent
    end
end

--如果报错就关闭该套接字
function handler.error(fd, msg)
    skynet.error("error -> fd:", fd, " msg:",msg)
    gateserver.closeclient(fd)  -- 关闭 fd
end

--fd中待发送数据超过1M时调用该函数，可以不处理
function handler.warning(fd, size)
    skynet.skynet("warning fd=", fd , "unsent data over 1M")
end


function CMD.kick(source, fd)
    skynet.error("source:", skynet.address(source), "kick fd:", fd)
    gateserver.closeclient(fd)
end

-- source 是消息的来源地址。这个方法的返回值，会通过 skynet.ret/skynet.pack 返回给来源服务。
function handler.command(cmd, source, ...)
    local f = assert(CMD[cmd])
    return f(source, ...)
end

-- register handlers here
gateserver.start(handler) --网关服务的入口函数
