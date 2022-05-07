# SYMFONY BASE ON DOCKER

## Getting started

```bash
ln -s ./.env.example ./.env
docker-compose build
make start
make exec-shell-web
    ## Enter on docker console
    # root@xxxxxxxxxxx:/var/www
    $  composer create-project symfony/website-skeleton project
    # type enter on question: Do you want to include Docker configuration from recipes? (Yes)
    $  exit
sudo chown -R $USER ./www
```
***
### To use database

> Add to file ./www/project/.env

```bash
# Commit line:
# DATABASE_URL="postgresql://symfony:ChangeMe@127.0.0.1:5432/app?serverVersion=13&charset=utf8"
# Add line
DATABASE_URL=mysql://DB_USER:DB_PASSWORD@db:3306/DB_NAME?serverVersion=5.7 ## REPLACE DB_USER, DB_PASSWORD and DB_NAME by value found in ./.env file
# F.E.
DATABASE_URL=mysql://docker_symfo_user:docker_symfo_user1234@db:3306/docker_symfo?serverVersion=5.7
```
***
### TESTING

We want to create `Test` entity with `tes` string field

> Enter on docker web console

```bash
make exec-shell-web
```
> Go to the project

```bash
cd project/
```

> Create entity

```bash
php bin/console make:entity
```
![Create entity success](images/Capture-20220507181728-741x547.png)

> Create migration

```bash
php bin/console make:migration
```

![Create migration success](images/Capture-20220507181801-666x167.png)

> Execute migration

```bash
php bin/console doctrine:migrations:migrate
```

![Execute migration success](images/Capture-20220507181826-1211x141.png)

> Adminer verification

![](images/Capture-20220507181927-677x339.png)
![](images/Capture-20220507181939-1605x620.png)
![](images/Capture-20220507181955-1078x534.png)

***
### Getting Chrome to accept self-signed localhost certificate For localhost only
```
chrome://flags/#allow-insecure-localhost
```

```bash
docker-compose exec web bash
composer create-project symfony/website-skeleton project
```
