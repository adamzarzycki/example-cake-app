
export DEPLOYMENT_NAMESPACE='test-namespace'

kubectl delete deployment cake-app-deployment -n $DEPLOYMENT_NAMESPACE
kubectl delete svc cake-app-service -n $DEPLOYMENT_NAMESPACE

kubectl delete deployment mysql -n $DEPLOYMENT_NAMESPACE
kubectl delete svc mysql-service -n $DEPLOYMENT_NAMESPACE

kubectl delete deployment phpmyadmin-deployment -n $DEPLOYMENT_NAMESPACE
kubectl delete svc phpmyadmin-service -n $DEPLOYMENT_NAMESPACE

kubectl delete secret mysql-pass -n $DEPLOYMENT_NAMESPACE
kubectl delete pvc database-pvc -n $DEPLOYMENT_NAMESPACE

kubectl delete ns test-namespace

echo "Sleep few seconds and wait for resources to be terminated..."
sleep 5

echo "\n-- Minikube clean finished\n"