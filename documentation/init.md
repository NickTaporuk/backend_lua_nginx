compile nginx
-------------
    export LUAJIT_LIB=/usr/local/lib
    export LUAJIT_INC=/usr/local/include/luajit-2.1
    export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
    ./configure \
            --with-ld-opt="-Wl,-rpath,/usr/local/bin/luajit" \
            --add-module=/home/nick/programs/lua_nginx/source/nginx-rtmp-module \
            --add-module=/home/nick/programs/lua_nginx/source/ngx_devel_kit-0.3.0 \
            --add-module=/home/nick/programs/lua_nginx/source/lua-nginx-module-0.10.6 \
            --with-http_flv_module \
            --with-http_ssl_module \
            --with-http_gzip_static_module \
            --with-pcre-jit \
            --error-log-path=/var/log/nginx/error.log \
            --http-log-path=/var/log/nginx/access.log \
            --with-http_geoip_module \
            --with-http_stub_status_module \
            --prefix=/etc/nginx \
            --sbin-path=/usr/sbin/nginx \
            --conf-path=/etc/nginx/nginx.conf \
            --error-log-path=/var/log/nginx/error.log \
            --http-log-path=/var/log/nginx/access.log \
            --pid-path=/var/run/nginx.pid \
            --lock-path=/var/run/nginx.lock \
            --http-client-body-temp-path=/var/cache/nginx/client_temp \
            --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
            --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
            --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
            --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
            --user=nginx \
            --group=nginx \
            --with-http_ssl_module \
            --with-http_realip_module \
            --with-http_addition_module \
            --with-http_sub_module \
            --with-http_dav_module \
            --with-http_flv_module \
            --with-http_mp4_module \
            --with-http_gunzip_module \
            --with-http_gzip_static_module \
            --with-http_random_index_module \
            --with-http_secure_link_module \
            --with-http_stub_status_module \
            --with-http_auth_request_module \
            --with-threads  \
            --with-stream \
            --with-stream_ssl_module  \
            --with-http_slice_module  \
            --with-mail \
            --with-mail_ssl_module \
            --with-file-aio \
            --with-http_v2_module \
            --with-ipv6 
    
    
    make -j2
    sudo make install

luarocks install
----------------
    link https://github.com/keplerproject/luarocks/wiki
    download and configuring
    
luarocks install lua-cjson
luarocks install oauth2

luarocks install Lua-cURL
    apt-get install libcurl4-openssl-dev for compile curl.h
    
luarocks install pgmoon
    postrgres client