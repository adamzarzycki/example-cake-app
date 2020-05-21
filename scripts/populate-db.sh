
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
sleep 30
mysql_docker_container=$(docker ps -a | grep example-cake-app_mysql |  cut -f 1 -d ' ')
echo "Mysql docker container: " $mysql_docker_container
docker exec -i $mysql_docker_container mysql -uroot -proot < $SCRIPTPATH/../deployment/sql/init.sql

if [ $? -eq 0 ]
then
    echo "Datasase populated"
    exit 0
else
    echo "----------------------------------------ERROR----------------------------------------"
    echo "Data import to mysql container failed, execute scripts/populate-db.sh manually "
    echo "-------------------------------------------------------------------------------------"
    exit 1
fi