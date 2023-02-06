#!/bin/bash

build_image() {
    IMAGE_NAME=${1?'Name of image'}
    DIR_DATALAKE='datalake'
    DIR_NOTEBOOK='notebook'

    if [ ! -d "$DIR_DATALAKE" ]; then
        mkdir $DIR_DATALAKE
    fi

    if [ ! -d "$DIR_NOTEBOOK" ]; then
        mkdir $DIR_NOTEBOOK
    fi

    docker build -t $IMAGE_NAME .

}

start_jupyter() {
    IMAGE_NAME=${1?'Name of image'}
    build_image $IMAGE_NAME
    docker run \
        -it \
        --rm \
        -p 8090:8888 \
        -v $PWD/:/home/jovyan/work \
        $IMAGE_NAME \
        start.sh jupyter lab --LabApp.token=''
}

"$@"
exit
