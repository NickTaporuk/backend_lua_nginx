local cjson = require "cjson"
local jwt = require "resty.jwt"
local mysql = require "resty.mysql"
-- -------------------------------------------------------------------------------

local db, err = mysql:new()

if not db then
    --    ngx.say("failed to instantiate mysql: ", err)
    ngx.exit(ngx.HTTP_FORBIDDEN)
end


local ok, err, errcode, sqlstate = db:connect{
    host = "127.0.0.1",
    port = 3306,
    database = "apartaments",
    user = "root",
    password = "root",
    max_packet_size = 1024 * 1024
}

db:set_timeout(1000)  -- 1 sec

if not ok then
    --    ngx.say("failed to connect: ", err, ": ", errno, " ", sqlstate)
    ngx.exit(ngx.HTTP_FORBIDDEN)
end

res, err, errcode, sqlstate =
db:query("select id,name,password from users")
if not res then
    ngx.say("bad result: ", err, ": ", errcode, ": ", sqlstate, ".")
    return
end
--[[for i,v in ipairs(res) do
    ngx.say(string.format("%s\t%s\t%s",v.id,v.name,v.password))
end]]

local cjson = require "cjson"
ngx.say(cjson.encode(res))

-- put it into the connection pool of size 100,
-- with 10 seconds max idle timeout
local ok, err = db:set_keepalive(10000, 100)
if not ok then
    ngx.say("failed to set keepalive: ", err)
    return
end
-- -------------------------------------------------------------------------------
--local jwt_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmb28iOiJiYXIifQ.VxhQcGihWyHuJeHhpUiq2FU7aW2s_3ZJlY6h1kdlmJY"
--local jwt_obj = jwt:verify("lua-resty-jwt", jwt_token)
--local str = cjson.encode(jwt_obj)
--ngx.say(str)

