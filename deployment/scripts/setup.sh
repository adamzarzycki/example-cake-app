SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export DEPLOYMENT_NAMESPACE='test-namespace'

echo "DOCKER_HOST: " $DOCKER_HOST " (yes, this should be empty)"
kubectl create namespace $DEPLOYMENT_NAMESPACE

#misc
kubectl apply -f $SCRIPTPATH/../k8s/secret.yml -n $DEPLOYMENT_NAMESPACE
kubectl apply -f $SCRIPTPATH/../k8s/pvc.yml -n $DEPLOYMENT_NAMESPACE

#mysql
kubectl apply -f $SCRIPTPATH/../k8s/deployment-mysql.yml -n $DEPLOYMENT_NAMESPACE
kubectl apply -f $SCRIPTPATH/../k8s/service-mysql.yml -n $DEPLOYMENT_NAMESPACE

#phpmyadmin
kubectl apply -f $SCRIPTPATH/../k8s/deployment-pma.yml -n $DEPLOYMENT_NAMESPACE
kubectl apply -f $SCRIPTPATH/../k8s/service-pma.yml -n $DEPLOYMENT_NAMESPACE

#php
kubectl apply -f $SCRIPTPATH/../k8s/deployment-cakeapp.yml -n $DEPLOYMENT_NAMESPACE
kubectl apply -f $SCRIPTPATH/../k8s/service-cakeapp.yml -n $DEPLOYMENT_NAMESPACE

# no need to run multiple times, can be commented after first usage
# if pvc will not be removed + namespace not deleted
sh $SCRIPTPATH/populate-db.sh

echo "Sleep few seconds and wait till resources will be deployed..."
sleep 3
minikube service cake-app-service -n $DEPLOYMENT_NAMESPACE
minikube service phpmyadmin-service -n $DEPLOYMENT_NAMESPACE

echo "\n-- Minikube setup done\n"