package.cpath = "luaclib/?.so" --  执行命令的当前目录 

-- ./3rd/lua/lua ./learn/testdhexchange.lua

local crypt = require "client.crypt"
-- 如果在skynet中使用直接 local crypt = require "skynet.crypt"


--产生一个8字节的随机数，一般作为对称加密算法的随机密钥
local randkey= crypt.randomkey()
print("crypt.randomkey():\t", crypt.hexencode(randkey))

-- DHexchange密钥交换算法
local clientkey = crypt.randomkey() --8byte random
local ckey = crypt.dhexchange(clientkey) -- dhexchange转换8字节的key
print("clientkey:" , crypt.hexencode(clientkey))
print("ckey:\t" , crypt.hexencode(ckey))

local serverkey = crypt.randomkey()
local skey = crypt.dhexchange(serverkey)
print("serverkey:" , crypt.hexencode(serverkey))
print("skey:\t" , crypt.hexencode(skey))



--通过skey 与 clientkey 得到密钥
local csecret = crypt.dhsecret(skey, clientkey)
print("use skey clientkey dhsecret:", crypt.hexencode(csecret)) --交换成功

local ssecret = crypt.dhsecret(ckey, serverkey)
print("use ckey serverkey dhsecret:", crypt.hexencode(ssecret)) --交换成功

local kksecret = crypt.dhsecret(ckey, skey)                  --交换失败
print("use ckey skey dhsecret:\t", crypt.hexencode(kksecret))






--HMAC64运算利用哈希算法，以一个密钥secret和一个消息challenge为输入，生成一个消息摘要hmac作为输出。
local challenge = crypt.randomkey()
local chmac = crypt.hmac64(challenge, csecret)
local shmac = crypt.hmac64(challenge, ssecret)
print("chmac.hmac64():\t", crypt.hexencode(chmac))
print("shmac.hmac64():\t", crypt.hexencode(shmac))


local str = "hi~ how are you"
local b64str = crypt.base64encode(str)
print("b64str:\t",b64str)
print("crypt.base64decode(b64str):\t",crypt.base64decode(b64str))

--用key加密plaintext得到密文，key必须是8字节
local plaintext = "base64(user@base64(用户名) server:base64(服务器id) passwd)"
local ciphertext = crypt.desencode(randkey, plaintext)
print("ciphertext:\t",crypt.hexencode(ciphertext))
--用key解密ciphertext得到明文，key必须是8字节
print("DES_decode:\t",crypt.desdecode(randkey, ciphertext))