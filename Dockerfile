FROM alpine:latest

RUN apk add --no-cache curl
RUN apk add --no-cache bind-tools
RUN apk add --no-cache jq
RUN apk add --no-cache msmtp
RUN apk update && apk upgrade --no-cache

COPY dyndns.sh /dyndns.sh

RUN echo '*/5 * * * * /bin/ash /dyndns.sh > /dev/null' >> /crontab.conf

RUN crontab /crontab.conf

CMD [ "/usr/sbin/crond", "-f", "-d8" ]
