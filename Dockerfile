FROM google/nodejs:0.10.32

RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common python-software-properties python-setuptools \
    procps nano

RUN /usr/bin/easy_install supervisor supervisor-stdout
ADD ./supervisord.conf /etc/supervisord.conf
ADD start.sh /start.sh
RUN chmod +x /start.sh

WORKDIR /app
ADD package.json /app/package.json
RUN npm install
ADD . /app

ENV PORT 8080
EXPOSE 8080

CMD '/start.sh'
