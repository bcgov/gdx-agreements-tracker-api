##Setup
Make sure the workspace can use the artifactory docker remote proxy.
```bash
oc secrets link default artifactory-docker-remote-creds --for=pull
```

Bring dockerhub node images in as openshift imagestreams.
```bash
export OC_NAMESPACE="acd38d"
oc project ${OC_NAMESPACE}-tools

oc process -f templates/base-images/node-16.yaml | oc apply -f -
oc process -f templates/base-images/postgres-14.yaml | oc apply -f -
```

S2I-ize node-16 for openshift. These are the basic node build and runtime images.
```bash
export OC_NAMESPACE="acd38d"
oc project ${OC_NAMESPACE}-tools

oc process -f s2i/nodejs/nodejs.yaml -p GIT_REF="development" | oc apply -f -
```

Build the api base image, and runtime image.
```bash
export OC_NAMESPACE="acd38d"
oc project ${OC_NAMESPACE}-tools

oc process -f templates/api/build.yaml -p GIT_REF="development" | oc apply -f -
```

Initialize the API deployment.
```bash
export OC_NAMESPACE="acd38d"
oc project ${OC_NAMESPACE}-tools

oc process -f templates/api/deploy.yaml | oc apply -f -
```

Stand up the API routes.
```bash
export OC_NAMESPACE="acd38d"
oc project ${OC_NAMESPACE}-tools

oc process -f templates/api/deploy-route.yaml | oc apply -f -
```
