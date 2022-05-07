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


## Getting Chrome to accept self-signed localhost certificate For localhost only
```
chrome://flags/#allow-insecure-localhost
```
