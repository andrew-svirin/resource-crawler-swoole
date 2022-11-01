FROM node:16.13.0

RUN apt-get update && apt-get install -y \
    sudo

ARG USER_ID
ARG GROUP_ID
ARG USER_NAME=node
ARG GROUP_NAME=node

# Add user
RUN userdel -f ${USER_NAME} \
    && if getent group ${GROUP_NAME} ; then groupdel ${GROUP_NAME}; fi \
    && groupadd -g ${GROUP_ID} ${GROUP_NAME} \
    && useradd -l -u ${USER_ID} -g ${GROUP_NAME} ${USER_NAME} && echo "${USER_NAME}:${GROUP_NAME}" | chpasswd \
    && adduser ${USER_NAME} sudo \
    && install -d -m 0755 -o ${USER_NAME} -g ${GROUP_NAME} "/home/${USER_NAME}" \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && chown --changes --silent --no-dereference --recursive ${USER_ID}:${GROUP_ID}  \
      "/home/${USER_NAME}" /var/log /var/www || true

USER ${USER_NAME}

WORKDIR /var/www/resource-crawler-swoole/client
