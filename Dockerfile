FROM alpine:latest
RUN apk update && apk add beanstalkd
ENV BINLOG=on
ENV FSYNC=10000
ENV JOB_SIZE=10485760
ENV COMPACT=false
VOLUME /binlog
COPY run.sh /run.sh
RUN chmod +x /run.sh
RUN ls -alh /run.sh
ENTRYPOINT ["/run.sh"]

