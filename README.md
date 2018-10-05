# taxi-fare-prediction
predict taxi fare prices from kaggle taxi fare dataset

## Dependencies and Installation

In order to run this repo, the primary dependencies are [docker](https://www.docker.com/) and [docker-compose](https://docs.docker.com/compose/).

To install `docker` via `curl`, run
```
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh
```

To install `docker-compose` (after installing docker)
```
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## How to build this repo

To build this repo run
```
./build.sh
```

## How to run this repo

TO run this repo run
```
./run.sh
```

After running this repo go to `localhost:8888` in your browser to access a jupyter notebook