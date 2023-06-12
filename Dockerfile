# 写在最前面：强烈建议先阅读官方教程[Dockerfile最佳实践]（https://docs.docker.com/develop/develop-images/dockerfile_best-practices/）
# 选择构建用基础镜像（选择原则：在包含所有用到的依赖前提下尽可能提及小）。如需更换，请到[dockerhub官方仓库](https://hub.docker.com/_/php?tab=tags)自行选择后替换。
FROM alpine:3.13

# 容器默认时区为UTC，如需使用上海时间请启用以下时区设置命令
# RUN apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone

# 使用 HTTPS 协议访问容器云调用证书安装
RUN apk add ca-certificates

# 安装依赖包，如需其他依赖包，请到alpine依赖包管理(https://pkgs.alpinelinux.org/packages?name=php8*imagick*&branch=v3.13)查找。
# 选用国内镜像源以提高下载速度

RUN add-apt-repository ppa:ondrej/php

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tencent.com/g' /etc/apk/repositories \
    && apk add --update --no-cache \
    php8.1 \
    php8.1-xml \
    php8.1-xmlrpc \
    php8.1-curl \
    php8.1-gd \
    php8.1-imagick \
    php8.1-cli \
    php8.1-dev \
    php8.1-imap \
    php8.1-mbstring \
    php8.1-opcache \
    php8.1-soap \
    php8.1-zip \
    php8.1-redis \
    php8.1-intl 
    php8.1-json \
    php8.1-ctype \
	php8.1-exif \
    php8.1-fpm \
    php8.1-session \
    php8.1-pdo_mysql \
    php8.1-tokenizer \
    nginx \
    && rm -f /var/cache/apk/*

# 设定工作目录
WORKDIR /app

# 将当前目录下所有文件拷贝到/app
COPY . /app

# 替换nginx、fpm、php配置
# RUN cp /app/conf/nginx.conf /etc/nginx/conf.d/default.conf \
#     && cp /app/conf/fpm.conf /etc/php8.1/php-fpm.d/www.conf \
#     && cp /app/conf/php.ini /etc/php8.1/php.ini \
#     && mkdir -p /run/nginx \
#     && chmod -R 777 /app/storage \
#     && mv /usr/sbin/php-fpm7 /usr/sbin/php-fpm

# # 暴露端口
# EXPOSE 80

# # 容器启动执行脚本
# CMD ["sh", "run.sh"]
