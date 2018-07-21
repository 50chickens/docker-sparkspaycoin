FROM ubuntu:xenial
MAINTAINER Oliver Gugger <gugger@gmail.com>

ARG USER_ID
ARG GROUP_ID
ARG VERSION

ENV USER sparks
ENV COMPONENT ${USER}
ENV HOME /${USER}
ENV COINFOLDER sparkscore
ENV COIN_DAEMON sparksd
ENV COINFOLDERVERSION ${COINFOLDER}-0.12.3
ENV COIN_VERSION 0.12.3.2
ENV COIN_TGZ https://github.com/SparksReborn/sparkspay/releases/download/v${COIN_VERSION}/${COINFOLDER}-${COIN_VERSION}-linux64.tar.gz
ENV COIN_BOOTSTRAP  https://github.com/SparksReborn/sparkspay/releases/download/bootstrap/bootstrap.dat

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -g ${GROUP_ID} ${USER} \
	&& useradd -u ${USER_ID} -g ${USER} -s /bin/bash -m -d ${HOME} ${USER}

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates wget software-properties-common gosu curl

RUN gosu nobody true

RUN wget -O /tmp/${COMPONENT}.tar.gz $COIN_TGZ \
    && cd /tmp/ \
    && tar zxvf ${COMPONENT}.tar.gz \
    && mv /tmp/${COINFOLDERVERSION} /opt/${COMPONENT}/ \
    && rm -rf /tmp/*

RUN mkdir ${HOME}/.${COINFOLDER}
RUN curl ${COIN_BOOTSTRAP} -L -o ${HOME}/.${COINFOLDER}/bootstrap.dat

EXPOSE 8890 8891 

WORKDIR ${HOME}
ADD ./bin /usr/local/bin
add ./conf ${HOME}/.${COINFOLDER}

RUN echo rpcuser=`dd if=/dev/urandom bs=33 count=1 2>/dev/null | base64` >> ${HOME}/.${COINFOLDER}/${COMPONENT}.conf
RUN echo rcpassword=`dd if=/dev/urandom bs=33 count=1 2>/dev/null | base64` >> ${HOME}/.${COINFOLDER}/${COMPONENT}.conf


ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["start-unprivileged.sh", "sparks", "sparksd"]

