#!/bin/sh

FORCE=0

while getopts 'fh' OPTION; do
  case "$OPTION" in
    f)
      FORCE=1
      ;;
    h)
      echo "Usage: $0 (-f) [your working directory]"
      exit 0
      ;;
  esac
done
shift "$(($OPTIND -1))"

if [ "$#" -ne 1 ]; then
    echo "Deployment directory is needed!"
    exit -1
fi

if ! [ -d $1 ]; then
    echo "Target needs to be a directory!"
    exit -1
fi

if [ -f $1/Dockerfile ] && [ $FORCE -ne 1 ] ; then
    echo "Refusing to overwrite existing Dockerfile! (-f overrides this)"
    exit -1
fi

if [ -f $1/docker-compose.yml ] && [ $FORCE -ne 1 ] ; then
    echo "Refusing to overwrite existing docker-compose.yml! (-f overrides this)"
    exit -1
fi

DIRNAME=$(dirname $0)
USER=$(whoami)

cp -v $DIRNAME/Dockerfile $1/
sed -i "s/USER/$USER/g" $1/Dockerfile
cp -v $DIRNAME/.devcontainer.json $1/
sed -i "s/USER/$USER/g" $1/.devcontainer.json
cp -v $DIRNAME/docker-compose.yml $1/
sed -i "s/USERNAME/$USER/g" $1/docker-compose.yml
