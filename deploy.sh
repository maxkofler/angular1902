#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Deployment directory is needed!"
    exit -1
fi

DIRNAME=$(dirname $0)
USER=$(whoami)

if ! [ -d $1 ]; then
    echo "Target needs to be a directory!"
    exit -1
fi

cp -v $DIRNAME/Dockerfile $1/
sed -i "s/RUN adduser -D USER/RUN adduser -D $USER/g" $1/Dockerfile
cp -v $DIRNAME/.devcontainer.json $1/
sed -i "s/\"remoteUser\": \"USER\"/\"remoteUser\": \"$USER\"/g" $1/.devcontainer.json
