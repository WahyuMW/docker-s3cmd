#!/bin/bash


#
# main entry point to run s3cmd
#
S3CMD_PATH=/opt/s3cmd/s3cmd

if [ -z "${aws_key}" ]; then
    echo "ERROR: The environment variable key is not set."
    exit 1
fi

if [ -z "${aws_secret}" ]; then
    echo "ERROR: The environment variable secret is not set."
    exit 1
fi

if [ -z "${cmd}" ]; then
    echo "ERROR: The environment variable cmd is not set."
    exit 1
fi


if [ -z "${bucket}" ]; then
    echo "ERROR: The environment variable bucket is not set."
    exit 1
fi

if [ -z "${thread}" ]; then
    echo "ERROR: The environment variable thread is not set."
    exit 1
fi

if [ -z "${size}" ]; then
    echo "ERROR: The environment variable size is not set."
    exit 1
fi

if [ -z "${s3_host_base}" ]; then
    echo "ERROR: The environment variable size is not set."
    exit 1
fi

echo "" >> /opt/.s3cfg
echo "access_key=${aws_key}" >> /opt/.s3cfg
echo "secret_key=${aws_secret}" >> /opt/.s3cfg
echo "host_base = ${s3_host_base}" >> /opt/.s3cfg
echo "host_bucket = ${s3_host_base}" >> /opt/.s3cfg

head -c ${size} /dev/urandom > /opt/src/object-test

if [ "${cmd}" != "interactive" ]; then
    if [ "${cmd}" = "put" ]; then
        i=1
        while [ $i -le ${num} ]
            do
            ${S3CMD_PATH} --config=/opt/.s3cfg ${cmd} /opt/src/object-test s3://${bucket}/object-test-${thread}-$i
            ((i++))
        done
    fi
    if [ "${cmd}" = "get" ]; then
        i=1
        while [ $i -le ${num} ]
            do
            ${S3CMD_PATH} --config=/opt/.s3cfg ${cmd} s3://${bucket}/object-test-${thread}-$i
            ((i++))
        done
    fi
fi





#
# Finished operations
#
echo "Finished s3cmd operations"
