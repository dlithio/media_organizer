FROM jupyter/base-notebook:latest
# Uses ubuntu 18.04 - https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile
# Follow the template seen here to add programs/conda/python
# 1) Conda only - https://github.com/jupyter/docker-stacks/blob/master/r-notebook/Dockerfile
# 2) pip install - https://github.com/jupyter/docker-stacks/blob/master/all-spark-notebook/Dockerfile

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    mediainfo \
    imagemagick && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN pip install --user --no-cache-dir pymediainfo && \
    fix-permissions /home/$NB_USER
