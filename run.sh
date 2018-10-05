IMAGE=jupyter.taxidata
docker run \
       -p 8888:8888 \
       -v $(pwd):/home:z \
       --rm \
       -w /home \
       -it $IMAGE
