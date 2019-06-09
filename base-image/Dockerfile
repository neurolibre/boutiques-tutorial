FROM mcin/docker-fsl

# Installation
RUN yum update -y && \
    yum install -y epel-release && \
    yum update -y && \
    yum install -y singularity-runtime singularity &&\
    yum install -y python36 python36-setuptools && \
    easy_install-3.6 pip &&\
    pip3 install boutiques && \
    pip3 install niwidgets && \
    pip3 install --no-cache-dir notebook==5.* &&\
    ln -fs /usr/bin/python3 /usr/bin/python

# Binder stuff
RUN useradd -d /home/boutiques -u 1000 boutiques &&\
    mkdir /home/boutiques/notebooks && mkdir -p /home/boutiques/.cache/boutiques
COPY notebooks /home/boutiques/notebooks
COPY Dockerhub/entrypoint /

# Tampering the cache so that descriptor runs without a container image
COPY Dockerhub/zenodo-1482743.json /home/boutiques/.cache/boutiques
RUN chown -R boutiques:boutiques /home/boutiques
USER boutiques
WORKDIR /home/boutiques
ENTRYPOINT ["/entrypoint"]

