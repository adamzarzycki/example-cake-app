SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
sh $SCRIPTPATH/scripts/clean.sh
docker-compose build | tee logs/docker-compose-build.log
docker-compose run cakephp composer install --no-interaction
docker-compose up &
sh $SCRIPTPATH/scripts/populate-db.sh