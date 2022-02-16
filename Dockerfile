FROM ubuntu:20.04

MAINTAINER Luca Garbin (service+github@lucagarbin.it)

RUN apt-get update -y
RUN apt-get install -y software-properties-common
RUN LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update -y && apt-get install -y \
     unzip \
     curl \
     git \
     vim \
     php7.3-cli \
     php7.3 \
     php7.3-curl \
     php7.3-gd \
     php7.3-json \
     php7.3-ldap \
     php7.3-mbstring \
     php7.3-mysql \
     php7.3-pgsql \
     php7.3-sqlite3 \
     php7.3-xml \
     php7.3-xsl \
     php7.3-zip \
     php7.3-soap \
     php7.3-imagick \
     ssh \
     php-pear \
     php7.3-dev \
     libaio1

RUN pecl -v

# Laravel PDF generator 1-devpendecies
RUN apt-get install -y libxrender1 libfontconfig libxext6

# install locales
RUN apt-get install -y locales && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN chmod a+x composer.phar
RUN mv composer.phar /usr/local/bin/composer

# Enable Apache mod rewrite
RUN /usr/sbin/a2enmod rewrite

# Edit apache2.conf to change apache site settings.
ADD apache2.conf /etc/apache2/

# Edit 000-default.conf to change apache site settings.
ADD 000-default.conf /etc/apache2/sites-available/

EXPOSE 80

WORKDIR /var/www/

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
