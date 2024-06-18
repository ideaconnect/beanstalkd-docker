FROM alpine:latest
RUN apk update
RUN apk add beanstalkd
ENV BINLOG_DIR=/binlog
ENV FSYNC=10000
ENV JOB_SIZE=10485760
ENV COMPACT=false
RUN if [ "${FSYNC}" -gt 0 ]; then export SYNC="-f ${FSYNC}"; else export SYNC="-F"; fi && \
    echo ${SYNC} && \
    if [ "${BINLOG_DIR}" != "off" ]; then export BINLOG="-b ${BINLOG_DIR}"; else export BINLOG=""; fi && \
    echo ${BINLOG} && \
    export COMMAND="beanstalkd -z ${JOB_SIZE} -l 0.0.0.0 -p 11300 ${SYNC} ${BINLOG} -n" && \
    echo ${COMMAND} > /bin/run.sh && \
    chmod +x /bin/run.sh
RUN cat /bin/run.sh
ENTRYPOINT /bin/run.sh
