# Example app running on local and in k8s

Why I used CakePHP - I already got this task from you. In 2016 I got almost the same assignment during recruitment process. I wanted to re-use old code for REST app. I ended up playing with new version of CakePHP to see what has change since last time I used it. Unfortunately code from older CakePHP version was not backward compatible, so I had to rewrite almost all from scratch. I haven't spent much time on application itself, focused more on local set-up and cluster deployment.

There is a lot of files - but most of it was created for a skeleton app. Project skeleton created with command:
```bash
composer create-project --prefer-dist cakephp/app:^3.8 example-cake-app
```
All deployment-related stuff in [deployment](deployment) folder.

Scripts for docker on local in [scripts](scripts) folder.

Additionally created files in root directory:
- [Dockerfile](Dockerfile)
- [docker-compose.yml](docker-compose.yml)
- [init.local.sh](init.local.sh)
- [init.minikube.sh](init.minikube.sh)
- [perform-actions.sh](scripts/perform-actions.sh)

Files modified in skeleton app:
- [config/app.php](config/app.php)
- [config/routes.php](config/routes.php)

Files added to skeleton app:
- [ProductsController](src/Controller/ProductsController.php)
- [CartsController](src/Controller/CartsController.php)
- [Entities](src/Model/Entity)
- [Tables](src/Model/Table)
- [Helper for rendering table in view](src/View/Helper/TableHelper.php)
- [View for all products](src/Template/Products/all.ctp)
- [View for all carts](src/Template/Carts/all.ctp)

Only hard dependency between local and cluster deployments is hostname of database - `mysql-service`. App requires [static host name](config/app.php#L259), so in docker-compose it's added as a [link](docker-compose.yml#L15) to 'mysql' container. In cluster [service](deployment/k8s/service-mysql.yml#L4) exposing access to mysql pods is also named `mysql-service`. No other static strings are used in app.

# Deployment

Both local and cluster setups based on images:
- php:7.3.3-apache
- mysql:5.6.39
- phpmyadmin/phpmyadmin:5.0.2

[Dockerfile](Dockerfile) used for both setups is the same.

## Local version

### Requirements for local version

- docker-compose in version 1.23.1 or higher
- Docker in version 19.03.2 or higher

### Building project locally
 
This will build and containerize whole app locally for development purpose. All changes to src folder will be available at runtime. Script requires to be executed from project root directory.
```bash
./init.local.sh
```
Logs from docker-compose build can be found in file [logs/docker-compose-build.log](logs/docker-compose-build.log).
Running script [perform-actions.sh](scripts/perform-actions.sh) will execute few curl calls to REST API to modify records stored in DB. 

### Endpoints

- App available at: [http://localhost:8081]
- View with all prodct list: [http://localhost:8081/products/all]
- REST endpoint: First page products: [http://localhost:8081/products.json]
- REST endpoint: 2nd page of products: [http://localhost:8081/products.json?page=2]
- REST endpoint: Product info: [http://localhost:8081/products/1.json]
- Phpmyadmin at: [http://localhost:8080] (p: root u: root)
- REST endpoint: all carts: [http://localhost:8081/carts.json]

### Cleaning docker

```bash
./scripts/clean.sh
```

## Cluster deployment

All resources can be found in [k8s folder](deployment/k8s). Whole stack is deployed into `test-namespace` namespace. 

### Requirements for cluster version

- Minikube in version 1.10.1 or higher
- Kubernetes in version 1.18.2 or higher
- kubectl
- Docker in version 19.03.2 or higher

### Building project in minikube

Run command from folder with minikube configuration (by default home folder)
```bash
./<path_to_this_repo>/init.minikube.sh
```
Uses same image as in case of local deployment

### Cleaning minikube

```bash
./deployment/scripts/clean.sh
```

## What can be fixed
- In both cases(local + cluster) data import to DB is done "not nice", script waits for X amount of seconds for containers to start and then directly inject data via cli. If machine is too slow import needs to be triggered once more manually. In cluster it can be executed as delayed Job. Anyway database should not be part of application repository.
- Add some logic to cart, stop using 'id' and start using 'cart_id'. Connect cart with current user, sum value of all products in cart etc
- Block adding non-existing products to cart
- In k8s build custom image for mysql and copy inside .cnf file, uncomment binding this file to mysql container. Currently mysql has wrong value in 'character-set-server'
- Run deployment in pipeline - dependencies can be passed as artifacts
- Stop copying everything to Dockerfile image (COPY . $APP_HOME), select only files, that are needed