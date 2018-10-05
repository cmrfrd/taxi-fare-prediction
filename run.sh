IMAGE=jupyter.taxidata
docker run \
       -p 8888:8888 \
       -v $(pwd):/home/jovyan/work/ \
       --rm \
       -it $IMAGE
