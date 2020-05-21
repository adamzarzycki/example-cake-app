SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

sh $SCRIPTPATH/deployment/scripts/start-minikube.sh
sh $SCRIPTPATH/deployment/scripts/clean.sh

# for minikube deployment test it can be commented, image will be present in minikube after first execution
sh $SCRIPTPATH/deployment/scripts/build.sh

sh $SCRIPTPATH/deployment/scripts/setup.sh