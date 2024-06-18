#!/bin/sh
if [ "${FSYNC}" -gt 0 ]; then export SYNC="-f ${FSYNC}"; else export SYNC="-F"; fi
echo ${SYNC}
if [ "${BINLOG_DIR}" != "off" ]; then export BINLOG="-b /binlog"; else export BINLOG=""; fi
echo ${BINLOG}
export EXEC_BIN="beanstalkd -z ${JOB_SIZE} -l 0.0.0.0 -p 11300 ${SYNC} ${BINLOG}"
echo Starting: ${EXEC_BIN}
${EXEC_BIN}
