local redis = require "resty.redis" -- подключаем библиотеку по работе с redis
local red = redis:new()

red:set_timeout(1000) -- 1 sec

local ok, err = red:connect("127.0.0.1", 6379)
if not ok then
    ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR) -- если не удалось подключиться, 
end                                          --  то возвращаем ответ со статусом 500


local phpsession = ngx.var.cookie_PHPSESSID -- получаем id сессии из cookie пользователя
local ROLE_ADMIN = "ROLE_ADMIN" -- роль, которой нужно предоставить доступ

if phpsession == ngx.null then
  ngx.exit(ngx.HTTP_FORBIDDEN) -- если в cookie нет сессии(пользователь не аутентифицированн), 
end                            -- то  возвращаем ответ со статусом 403

local res, err = red:hget("phpsession:" .. phpsession, "user-role") -- получаем роль пользователя 
                                                                    -- из redis по id сессии

if res == ngx.null or res ~= ROLE_ADMIN then 
    ngx.exit(ngx.HTTP_FORBIDDEN) -- если сессии нет(закончилось время жизни сессии) или 
end                              --  у пользователя не та роль,  что нам нужна,
                                 -- то  возвращаем ответ со статусом 403
