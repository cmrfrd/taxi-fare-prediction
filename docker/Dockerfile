FROM beakerx/beakerx

## Install apt dependencies
USER root
RUN apt-get update && \
    apt-get install -y apt-transport-https \
    	    	       build-essential \
                       sudo

## Make default beakerx user sudoer
RUN echo "beakerx ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers
USER beakerx

## Install python dependencies
RUN bash -c "source activate beakerx"
RUN conda install -n beakerx -c pyviz geoviews nodejs && \
    conda install -n beakerx -c conda-forge nodejs pip
ADD requirements.txt /requirements.txt
RUN pip install --user -r /requirements.txt

## Set permissions for beakerx for npm installations
RUN sudo chown beakerx:beakerx -R \
	/opt/conda/etc/\
	/home/beakerx/.npm\
	/home/beakerx/.config

RUN bash -c "\
	source activate beakerx;\
	jupyter labextension install @pyviz/jupyterlab_pyviz &&\
        jupyter labextension install @jupyter-widgets/jupyterlab-manager &&\
	jupyter nbextension enable --py widgetsnbextension &&\
	jupyter nbextension enable codefolding/main"

## Configure entrypoint and cmd
ENTRYPOINT [ "bash", "-c" ]
CMD ["source activate beakerx && /usr/local/bin/start.sh jupyter lab --ip=0.0.0.0 --notebook-dir=/home/beakerx/work --NotebookApp.iopub_data_rate_limit=10000000 --NotebookApp.token= --allow-root"]
