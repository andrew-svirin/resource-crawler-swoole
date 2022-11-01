FROM php:8.1.7-cli

RUN apt-get update && apt-get install -y \
    libxml2-dev \
    zlib1g-dev \
    git \
    unzip \
    libssh-dev \
    libzip-dev \
    supervisor \
    sudo

RUN pecl install xdebug
RUN pecl install openswoole
RUN docker-php-ext-enable xdebug
RUN docker-php-ext-enable openswoole
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install zip

#Install composer
RUN ln -sf /usr/local/bin/php /usr/bin/php && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --version=2.3.7 --filename=composer

ARG USER_ID
ARG GROUP_ID
ARG USER_NAME=www-data
ARG GROUP_NAME=www-data

# Add user
RUN userdel -f ${USER_NAME} \
    && if getent group ${GROUP_NAME} ; then groupdel ${GROUP_NAME}; fi \
    && groupadd -g ${GROUP_ID} ${GROUP_NAME} \
    && useradd -l -u ${USER_ID} -g ${GROUP_NAME} ${USER_NAME} && echo "${USER_NAME}:${GROUP_NAME}" | chpasswd \
    && adduser ${USER_NAME} sudo \
    && install -d -m 0755 -o ${USER_NAME} -g ${GROUP_NAME} "/home/${USER_NAME}" \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && chown --changes --silent --no-dereference --recursive ${USER_ID}:${GROUP_ID}  \
      "/home/${USER_NAME}" /var/lib/php/sessions /var/log /var/www || true

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

COPY ./supervisord.conf /etc/supervisord.conf
COPY ./supervisor.d/app-swoole.conf /etc/supervisor/conf.d/app-swoole.conf
RUN chmod 777 /run

COPY ./php.ini /usr/local/etc/php/custom.d/php.ini
COPY ./php.d/xdebug.ini /usr/local/etc/php/custom.d/xdebug.ini

COPY .bashrc /root/.bashrc
COPY .bashrc /home/${USER_NAME}/.bashrc
RUN chown ${USER_NAME}:${GROUP_NAME} /home/${USER_NAME}/.bashrc

USER ${USER_NAME}

WORKDIR /var/www/resource-crawler-swoole/server

ENTRYPOINT ["/docker-entrypoint.sh"]