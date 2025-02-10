FROM centos:7

LABEL maintainer="https://github.com/heal2017"

RUN \
    mkdir -p /etc/yum.repos.d/backup && \
    mv /etc/yum.repos.d/*repo /etc/yum.repos.d/backup && \
    curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo && \
    sed -i 's/http:/https:/g' /etc/yum.repos.d/CentOS-Base.repo && \
    curl -o /etc/yum.repos.d/epel.repo https://mirrors.aliyun.com/repo/epel-7.repo && \
    sed -i 's/http:/https:/g' /etc/yum.repos.d/epel.repo && \
    yum install net-tools -y && \
    yum install iproute -y && \
    yum install cronie -y && \
    yum install expect -y && \
    yum install telnet -y && \
    yum install vim -y && \
    yum install tini -y && \
    yum clean all

ENV RES_PATH="/resources"
ENV TMP_PATH="/tmp"
ENV LANG="en_US.UTF-8"
ENV USERNAME="john"
ENV PASSWORD="john"
ENV UID="501"
ENV GID="501"
ENV USERSHELL="/usr/bin/bash"
ENV ROOT_PASSWORD="root"
ENV VNC_PASSWORD="john"
ENV GEOMETRY="1920x1080"

COPY --chmod=755 ./resources ${RES_PATH}

RUN \
    . ${RES_PATH}/scripts/define.sh && \
    . ${RES_PATH}/builds/create_user.sh && \
    . ${RES_PATH}/builds/build.sh

USER ${USERNAME}
WORKDIR /home/${USERNAME}
CMD ["/usr/bin/tini", "-s", "/resources/entrypoint.sh"]

