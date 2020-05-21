SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export DEPLOYMENT_NAMESPACE='test-namespace'

echo "Lets wait few seconds for mysql container to create, before attempting insert..."
echo "This is done only once, if script fails execute this file manually later"
sleep 30
mysql_pod_name=$(kubectl get pods -n $DEPLOYMENT_NAMESPACE | grep mysql |  cut -f 1 -d ' ')
echo "Mysql pod name: " $mysql_pod_name
kubectl -n $DEPLOYMENT_NAMESPACE exec -i $mysql_pod_name -- mysql -uroot -proot < $SCRIPTPATH/../sql/init.sql

if [ $? -eq 0 ]
then
    echo "\n-- DB setup finished\n"
    exit 0
else
    echo "\n----------------------------------------ERROR----------------------------------------"
    echo "Probably machine is to slow, need more time for DB to start, maybe set sleep to 60"
    echo "-------------------------------------------------------------------------------------\n"
    exit 1
fi