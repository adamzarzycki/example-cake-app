minikube status > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "Minikube already running"
else
    echo "Starting minikube"
    minikube start
fi