FROM php:7.4-fpm

#ARG TIMEZONE
#ARG UID
#ARG GID

#RUN groupadd -g ${UID} -r application && useradd --uid ${UID} --gid ${UID} --create-home -r -g application application

RUN apt-get --allow-releaseinfo-change update
RUN apt-get install -y \
    autoconf \
    entr \
    g++ \
    git \
    gnupg2 \
    imagemagick \
    intltool \
    libfreetype-dev \
    libicu-dev \
    libjpeg-dev \
    libmcrypt-dev \
    libpng-dev \
    libsqlite3-0 \
    libssl-dev \
    libzip-dev \
    openssl \
    pkg-config \
    poppler-utils \
    sqlite3 \
    unoconv \
    unzip \
    wget \
    zip

# Install Composer
COPY --from=composer /usr/bin/composer /usr/local/bin/composer
RUN composer --version

# Set timezone
#RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone
#RUN printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /usr/local/etc/php/conf.d/tzone.ini
#RUN "date"

# install xdebug
RUN echo "memory_limit=-1" >> /usr/local/etc/php/php.ini
RUN echo "upload_max_filesize=20M" >> /usr/local/etc/php/php.ini
RUN echo "post_max_size=20M" >> /usr/local/etc/php/php.ini
RUN echo "default_charset = \"ISO-8859-1\"" >> /usr/local/etc/php/php.ini

RUN docker-php-ext-configure intl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

RUN docker-php-ext-install pdo pdo_mysql intl bcmath zip gd
RUN docker-php-ext-enable gd

RUN pecl install mcrypt
RUN docker-php-ext-enable mcrypt

RUN echo 'alias sf="php bin/console"' >> ~/.bashrc

WORKDIR /var/www/app

USER application
