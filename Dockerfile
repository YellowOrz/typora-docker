FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble 


ARG TYPORA_VERSION

ENV TITLE=typora

COPY ./icon/typora.png /kclient/public/icon.png

RUN \
  echo "**** install packages ****" && \
  apt update && \
  apt install -y --no-install-recommends wget libasound2t64 libgbm1 libgtk-3-0t64 libdrm2 libcups2t64 \
    libatk-bridge2.0-0t64 libatk1.0-0t64 libglib2.0-0 libnss3 libdbus-1-3 && \
  if [ -z ${TYPORA_VERSION+x} ]; then \
    TYPORA_VERSION=$(curl https://typora.io/#linux |grep -oP '\d+\.\d+\.\d+(?=_amd64.deb)'); \
  fi && \
  echo "typora version ${TYPORA_VERSION}" && \
  wget -O /tmp/typora_linux_amd64.deb https://download2.typoraio.cn/linux/typora_${TYPORA_VERSION}_amd64.deb && \
  apt install -y --no-install-recommends /tmp/typora_linux_amd64.deb && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
