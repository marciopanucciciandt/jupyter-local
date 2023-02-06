ARG BASE_CONTAINER=jupyter/pyspark-notebook
FROM $BASE_CONTAINER

#### Install system requirements ####
USER root
RUN apt-get -qq update && \
    apt-get install -y --no-install-recommends apt-utils libpostgresql-jdbc-java libpostgresql-jdbc-java-doc

#### Install python requirements ####
USER $NB_UID
WORKDIR /opt/local_jupyter/
ADD requirements.txt .
RUN pip install --quiet -r requirements.txt
