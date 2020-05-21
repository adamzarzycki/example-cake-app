docker stop example-cake-app_pma
docker stop example-cake-app_mysql
docker stop example-cake-app_cakephp

mysql_docker_container=$(docker ps -a | grep example-cake-app_mysql |  cut -f 1 -d ' ')
echo "Mysql docker container: " $mysql_docker_container
docker rm $mysql_docker_container

docker volume rm example-cake-app_mysql_data

echo "\n-- Docker clean finished\n"

# docker system prune --volumes
