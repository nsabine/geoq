# GeoQ on OpenShift
Use these instruction to develop GeoQ applications on the OpenShift app platform.

## Container Development Kit
If you don't have access to an OpenShift cluster, no problem! Setting up a local OpenShift system is easy with the [Container Development Kit](http://developers.redhat.com/products/cdk/overview/).

## Build your database image
GeoQ requires the PostGIS extensions to be present in your PostgreSQL container. These instructions assume you're using the CDK. If you're using a different OpenShift deployment, you'll need to adjust these commands.

```
# Log into the CDK environment: 
cd ~/cdk/components/rhel/rhel-osp
vagarant ssh
# Log into OSE as admin 
oc login -u admin -p admin
git clone https://github.com/jason-callaway/geoq-postgresql.git --recursive
cd geoq-postgresql/rhel7.rh-postgis2_94
 docker build -t postgis .
# Determine the registry IP and image ID
REGISTRY=$(oc get services/docker-registry | grep ^docker | awk '{    print $2}')
IMAGE_ID=$(docker images | grep ^postgis | awk '{print $3}')
# Tag the image
docker tag ${IMAGE_ID} ${REGISTRY}:5000/openshift/postgis:latest
docker tag ${IMAGE_ID} ${REGISTRY}:5000/openshift/postgis:2_94
# Push to the registry
docker push ${REGISTRY}:5000/openshift/postgis:latest
docker push ${REGISTRY}:5000/openshift/postgis:2_94
```

