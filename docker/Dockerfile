FROM continuumio/anaconda3

## Setup env variables
ENV CONDA_DIR /opt/conda
ENV PATH /opt/conda/bin:$PATH
ENV NB_USER jovyan
ENV DEBIAN_FRONTEND noninteractive

## Install apt dependencies
USER root
RUN apt-get update && \
    apt-get install -y apt-transport-https \
	build-essential \
	sudo \
	apt-utils \
	curl \
	unzip \
	software-properties-common \
	git \
	bzip2 \
	wget \
	locales && apt-get clean

## Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install yarn -y

## Make jovyan user sudoer
RUN useradd jovyan --create-home &&\
    echo "jovyan ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers
USER jovyan

## Install python based dependencies in conda env
RUN conda create -y -n jovyan 'python>=3' nodejs pandas openjdk maven py4j
RUN conda config --env --add pinned_packages 'openjdk >8.0.121'
RUN conda install -y -n jovyan -c conda-forge ipywidgets jupyterhub jupyterlab pyzmq pytest requests pip beakerx
RUN conda install -n jovyan -c pyviz/label/dev pyviz
ADD requirements.txt /requirements.txt
RUN bash -c "source activate jovyan;\
             pip install --user -r /requirements.txt"


## Configure jupyter and install extensions
RUN bash -c "\
	source activate jovyan;\
	jupyter serverextension enable --py --sys-prefix jupyterlab &&\
	jupyter labextension install @pyviz/jupyterlab_pyviz &&\
	jupyter labextension install @jupyter-widgets/jupyterlab-manager &&\
	jupyter nbextension enable --py widgetsnbextension &&\
	jupyter nbextension enable codefolding/main"

## Add startup scripts and jupyter configuration
COPY start.sh start-notebook.sh start-singleuser.sh /usr/local/bin/
COPY jupyter_notebook_config.py /etc/jupyter/

## Configure entrypoint and cmd
ENTRYPOINT [ "/usr/bin/tini", "--", "bash", "-c" ]
CMD ["source activate jovyan && /usr/local/bin/start.sh jupyter lab --ip=0.0.0.0 --notebook-dir=/home/jovyan/work --NotebookApp.iopub_data_rate_limit=10000000 --NotebookApp.token= --allow-root"]
