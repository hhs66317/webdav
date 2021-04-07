# webdav

## Features

alpine 通过 apk 安装 nginx nginx-mod-http-dav-ext nginx-mod-http-fancyindex nginx-mod-http-headers-more openssl curl 后制作

支持 `-e USERNAME xxx -e PASSWORD xxx` 设置单用户登录

支持 `-e TZ Asia/Shanghai` 设置时区，默认为 `Asia/Shanghai`

支持 `-v /your/htpasswd:/etc/nginx/htpasswd` 设置多用户登录

支持 https ，默认是http，配好证书的话，可以直接启用https

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
      TZ: "Asia/Shanghai"
    volumes:
      - /share/homes/admin/.Qsync/webdav:/data
      - /share/Public/webdav/conf/nginx.conf:/etc/nginx/nginx.conf
      - /share/Public/webdav/conf/certs:/etc/nginx/certs
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
    environment:
      TZ: "Asia/Shanghai"
    volumes:
      - /share/homes/admin/.Qsync/webdav:/data
      - /share/Public/webdav/conf/htpasswd:/etc/nginx/htpasswd
      - /share/Public/webdav/conf/nginx.conf:/etc/nginx/nginx.conf
      - /share/Public/webdav/conf/certs:/etc/nginx/certs
    restart: unless-stopped
    ports:
     - 80:80
```

默认情况下，多用户模式下，所有用户都拥有根目录/data 下的读写权限。

如果需要不同用户根目录限定在独立的文件夹中 `/data/$remote_user` ，只有特定用户 `matthew` 根目录为 `/data` ，如果你也有这样的需求，只需要在多用户场景下，修改nginx.conf即可
```
http {
    ...

    map $remote_user $profile_directory {
        default      /data/$remote_user;
        matthew     /data;
    }
    
    server {
    ...

        location / {
            ...
            root $profile_directory;

        }
    }
}

```

- 支持多用户；运行容器前，需要在线网站生成并配置好 `htpasswd` 文件（默认 Md5 算法加密）

- 把需要共享的文件挂载在 `/data` 目录下

- 把用户信息挂载在 `/etc/nginx/htpasswd` 目录下

- 把ssl证书挂载在 `/etc/nginx/certs` 目录下

- 把nginx.conf挂载在 `/etc/nginx/nginx.conf` 目录下，方便修改
