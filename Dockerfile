FROM alpine:3.3
FROM bash:4.4

RUN apk update
RUN apk add python py-pip py-setuptools git ca-certificates
RUN pip install python-dateutil

RUN git clone https://github.com/s3tools/s3cmd.git /opt/s3cmd
RUN ln -s /opt/s3cmd/s3cmd /usr/bin/s3cmd

WORKDIR /opt

# Folders for s3cmd optionations
RUN mkdir /opt/src
RUN mkdir /opt/dest

ADD ./files/s3cfg /opt/.s3cfg
ADD ./files/main.sh /opt/main.sh

# Main entrypoint script
RUN chmod +x /opt/main.sh

WORKDIR /
CMD ["bash", "/opt/main.sh"]
