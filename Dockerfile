FROM devwithlando/php:8.3-apache-4

RUN apt-get update -qq && \
    apt-get purge -y -qq libmagickwand* && \
    apt-get autoremove -y -qq && \
    rm -rf /etc/ImageMagick-6 && \
    apt-get install -y -qq ghostscript && \
    cd /root && \
    git clone https://github.com/ImageMagick/ImageMagick.git imagemagick && \
    cd imagemagick && \
    git checkout -b latest $(git describe --tags $(git rev-list --tags --max-count=1)) && \
    ./configure && \
    make && \
    make install && \
    ldconfig /usr/local/lib && \
    rm -rf /root/imagemagick && \
    sed -i 's/<policy domain="coder" rights="read|write" pattern="{GIF,JPEG,PNG,WEBP}" \/>/<policy domain="coder" rights="read|write" pattern="{GIF,JPEG,PDF,PNG,WEBP}" \/>/g' /usr/local/etc/ImageMagick-7/policy.xml && \
    curl https://pecl.php.net/get/imagick-3.7.0.tgz -L -o /root/imagick.tar.gz && \
    tar -xzf /root/imagick.tar.gz -C /root && \
    cd /root/imagick-3.7.0 && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    rm -rf /root/imagick-3.7.0 /root/imagick.tar.gz && \
    docker-php-ext-enable imagick && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
