# webdav

## Reference

http://nginx.org/en/docs/http/ngx_http_dav_module.html

https://github.com/arut/nginx-dav-ext-module

https://github.com/openresty/headers-more-nginx-module

## Features

源码编译 nginx + http_dav_module + nginx-dav-ext-module + headers-more-nginx-module安装，镜像体积小

支持 `-e USERNAME xxx -e PASSWORD xxx` 设置单用户登录

支持 `-v /your/htpasswd:/opt/nginx/conf/htpasswd:ro` 设置多用户登录

多用户登录方式优先级更高

## Github

https://github.com/hhs66317/webdav

## Docker hub

https://hub.docker.com/r/hhs66317/webdav

## Usage

docker pull
```
docker pull hhs66317/webdav
```

根据自己情况修改-单用户
```
version: "3"
services:
  webdav:
    image: hhs66317/webdav
    container_name: webdav
    hostname: webdav
    environment:
      USERNAME: matthew
      PASSWORD: EMLsRqL8iNbgg7iaqqQ4EXfNebUzZric
    volumes:
      - /share/homes/admin/.Qsync/webdav:/data
      - /share/Public/webdav/conf/nginx.conf:/opt/nginx/conf/nginx.conf:ro
    restart: unless-stopped
    ports:
     - 80:80
```

根据自己情况修改-多用户
```
version: "3"
services:
  webdav:
    image: hhs66317/webdav
    container_name: webdav
    hostname: webdav
    volumes:
      - /share/homes/admin/.Qsync/webdav:/data
      - /share/Public/webdav/conf/htpasswd:/opt/nginx/conf/htpasswd:ro
      - /share/Public/webdav/conf/nginx.conf:/opt/nginx/conf/nginx.conf:ro
    restart: unless-stopped
    ports:
     - 80:80
```

- 支持多用户；运行容器前，需要在线网站生成并配置好 `htpasswd` 文件（默认 Md5 算法加密）

- 把需要共享的文件挂载在 `/data` 目录下

- 把用户信息挂载在 `/opt/nginx/conf/htpasswd` 目录下

- 把nginx.conf挂载再 `/opt/nginx/conf/nginx.conf` 目录下，方便修改

备注：为了解决一些 webdav 使用中的一些问题，根据 https://www.github.com/duxlong/webdav 修改而来

