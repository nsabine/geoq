#!/bin/bash -x

oc delete all -l template=geoq
sleep 3
oc process -f geoq-nick.json -v SOURCE_REPOSITORY_URL="https://github.com/nsabine/geoq" | oc create -f -
