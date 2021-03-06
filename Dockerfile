FROM registry.fit2cloud.com/public/python:v3
LABEL maintainer="jasonzhao <jason.zhao@hp.com>"

WORKDIR /opt/jumpserver
RUN mkdir /opt/jumpserver/tmp
RUN useradd jumpserver

COPY ./requirements /tmp/requirements

RUN yum -y install epel-release openldap-clients telnet && \
    cd /tmp/requirements && \
    yum -y install $(cat rpm_requirements.txt) && \
    pip install -i https://mirrors.aliyun.com/pypi/simple/ -r requirements.txt || pip install -r requirements.txt

COPY . /opt/jumpserver
RUN echo > config.yml
VOLUME ["/opt/jumpserver/data", "/opt/jumpserver/logs"]

ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

EXPOSE 8080
ENTRYPOINT ["./entrypoint.sh"]
