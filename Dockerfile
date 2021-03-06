FROM node:6.10.1-alpine

RUN apk add --no-cache tzdata curl git python make g++ libffi-dev openssl-dev avahi-compat-libdns_sd avahi-dev openrc dbus

RUN yarn global add node-gyp
RUN yarn global add homebridge

RUN mkdir /homebridge && mkdir -p /home/root/homebridge
WORKDIR /homebridge

COPY default.package.json /home/root/homebridge
COPY default.config.json /home/root/homebridge

VOLUME /homebridge

RUN mkdir /init.d
COPY init.d/ /init.d
ENTRYPOINT ["/init.d/entrypoint.sh"]

CMD ["homebridge", "-U", "/homebridge", "-P", "/homebridge/node_modules"]
