#!/bin/bash -e

PREFIX=

N=${1?}

IMAGE_NAME=${PWD##*/}_${N?}

DOCKER_REPO=msapatternsmultirepo

FNL=${DOCKER_REPO}/${N?}:latest
FN=${DOCKER_REPO}/${N?}:0.${CIRCLE_BUILD_NUM?}

docker login -u ${DOCKER_USER_ID?} -p ${DOCKER_PASSWORD?}

docker-compose build ${N}

$PREFIX docker tag ${IMAGE_NAME} ${FN}
$PREFIX docker tag ${IMAGE_NAME} ${FNL}

$PREFIX docker push ${FN}
$PREFIX docker push ${FNL}
