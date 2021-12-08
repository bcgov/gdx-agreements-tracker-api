##Setup
Make sure the workspace can use the artifactory docker remote proxy.
```bash
oc secrets link default artifactory-docker-remote-creds --for=pull
```

```bash
export OC_NAMESPACE="acd38d"
oc project ${OC_NAMESPACE}-tools

# Bring dockerhub node images in as openshift imagestreams.
oc process -f templates/base-images/node-16.yaml | oc apply -f -
oc process -f templates/base-images/postgres-14.yaml | oc apply -f -

# S2I-ize node-16 for openshift. These are the basic node build and runtime images.
oc process -f s2i/nodejs/nodejs.yaml -p GIT_REF="development" | oc apply -f -

# Build the api base image, and runtime image.
oc process -f templates/api/build.yaml -p GIT_REF="development" | oc apply -f -

# Initialize the API container deployment.
oc process -f templates/api/deploy.yaml | oc apply -f -

# Stand up the API routes.
oc process -f templates/api/deploy-route.yaml | oc apply -f -

# Configure the PostgreSQL deployment.
oc process -f templates/postgres/config.yaml -p POSTGRES_REGULAR_USER_PASSWORD=changeTHISstring -p POSTGRES_ROOT_PASSWORD=changeTHISstringTOO | oc apply -f -

# PostgreSQL persistent storage setup.
oc process -f templates/postgres/deploy.yaml | oc apply -f -

# Build the PostgreSQL containers.
oc process -f templates/posgres/build.yaml | oc apply -f -

# PostgreSQL deployment.
oc process -f templates/postgres/deploy.yaml | oc apply -f -
```
