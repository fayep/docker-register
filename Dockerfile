FROM alpine
MAINTAINER Jason Wilder <jason@influxdb.com>

RUN apk update
RUN apk add py-pip openssl

RUN mkdir /app
WORKDIR /app

RUN pip install python-etcd

ADD . /app

ENV DOCKER_HOST unix:///var/run/docker.sock

CMD /app/docker-gen -interval 10 -watch -notify "python /tmp/register.py" etcd.tmpl /tmp/register.py
