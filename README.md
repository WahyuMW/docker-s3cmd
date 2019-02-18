
S3CMD DOCKER FOR TESTING STORAGE CLUSTER
============
this docker continer is modified from https://github.com/sekka1/docker-s3cmd

# Description

s3cmd in a Docker container.  This is useful if you are already using Docker.
You can simply pull this container to that Docker server and move things between the local box and S3 by just running
a container.

Using [Alpine linux](https://hub.docker.com/_/alpine/).  This image is 31MB.

You can find an automated build of this container on the Docker Hub: https://hub.docker.com/r/garland/docker-s3cmd/

# More custom tag
this docker container I use to TEST my storage cluster production in [Bukalapak](https://github.com/bukalapak). this docker container have some the advantage, it can put or get multiple time. you can also can modify object size.
## usage info:

    aws_key = access key to access your storage cluster
    aws_secret = secret key to access your storage cluster
    s3_host_base = your ip and port of your storage cluster (exm s3_host_base=192.168.1.110:7480 )
    cmd = put or get (put,get)
    bucket = your bucket name
    thread = if you want to run docker multiple time it will add tag to your object test so it will not override previous object test from previous docker container
    size = size of your object test
    num = number of put or get that you want to execute

example 
```
    docker run \
    --env aws_key=${AWS_KEY} \
    --env aws_secret=${AWS_SECRET} \
    --env cmd=put \
    --env bucket=mybucket  \
    --env s3_host_base=192.168.1.110:7480 \
    --env thread=1 \
    --env size=4096 \
    --env num=1000 \
    wahyumuqsita/docker-s3cmd
```

## Run interactively with s3cmd

    AWS_KEY=<YOUR AWS KEY>
    AWS_SECRET=<YOUR AWS SECRET>

    docker run -it \
    --env aws_key=${AWS_KEY} \
    --env aws_secret=${AWS_SECRET} \
    --env cmd=interactive \
    garland/docker-s3cmd /bin/sh

Then execute the `main.sh` script to setup the s3cmd config file

    /opt/main.sh

Now you can run `s3cmd` commands

    s3cmd ls /
