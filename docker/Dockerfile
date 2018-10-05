FROM jupyter/scipy-notebook

## Change user to root for ease of installation
USER root

## Install apt dependencies
RUN apt-get update && \
    apt-get install -y apt-transport-https \
    	    	       build-essential

## Install pip dependencies
ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

## Configure jupyterlab
RUN jupyter serverextension enable --py --sys-prefix jupyterlab && \
    jupyter labextension install @pyviz/jupyterlab_pyviz && \
    jupyter contrib nbextension install --system       && \
    jupyter nbextension enable --py --sys-prefix widgetsnbextension && \
    jupyter nbextension enable codefolding/main

## Configure entrypoint and cmd
ENTRYPOINT ["tini", "--"]
CMD ["/usr/local/bin/start.sh", "jupyter", "lab", "--ip=0.0.0.0", "--notebook-dir=/home", "--NotebookApp.iopub_data_rate_limit=10000000 --NotebookApp.token="]
