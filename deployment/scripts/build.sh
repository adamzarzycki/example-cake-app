eval $(minikube docker-env)
echo "DOCKER_HOST: " $DOCKER_HOST
echo "Using docker in minikube"
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
docker build --no-cache -t cake-app:latest $SCRIPTPATH/../../
docker images | grep -E 'cake-app'
echo "\n-- Images build \n"