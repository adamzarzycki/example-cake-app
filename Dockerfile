# based on https://blog.cloud66.com/deploying-your-cakephp-applications-with-cloud-66/
# and https://medium.com/@jeremy_68921/deploying-cakephp-3-7-applications-using-docker-52a5a44cbe3c

FROM php:7.3.3-apache
RUN apt-get update && apt-get install -y \
  libicu-dev \
  curl \
  libpq-dev \
  mysql-client \
  git \
  zip \
  unzip \
  # https://github.com/Safran/RoPA/issues/4
  libzip-dev \
  # https://stackoverflow.com/questions/2977662/php-zip-installation-on-linux
  zlib1g-dev \
  && rm -r /var/lib/apt/lists/*
RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
  && docker-php-ext-install \
  intl \
  mbstring \
  pcntl \
  pdo_mysql \
  zip \
  opcache

RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
   mv composer.phar /usr/local/bin/ \
   && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

ENV APP_HOME /var/www/html

RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

RUN sed -i -e "s/html/html\/webroot/g" /etc/apache2/sites-enabled/000-default.conf

RUN a2enmod rewrite

COPY . $APP_HOME

RUN composer install --no-interaction --no-plugins --no-scripts

RUN chown -R www-data:www-data $APP_HOME