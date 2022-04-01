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
     php8.1-cli \
     php8.1 \
     php8.1-curl \
     php8.1-gd \
     php8.1-ldap \
     php8.1-mbstring \
     php8.1-mysql \
     php8.1-pgsql \
     php8.1-sqlite3 \
     php8.1-xml \
     php8.1-xsl \
     php8.1-zip \
     php8.1-soap \
     php8.1-imagick \
     ssh \
     php-pear \
     php8.1-dev \
     libaio1

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
