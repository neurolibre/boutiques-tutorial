FROM mcin/docker-fsl

# Installation
RUN yum update -y && \
    yum install -y epel-release && \
    yum update -y && \
    yum install -y python36 python36-setuptools && \
    easy_install-3.6 pip &&\
    pip3 install boutiques && \
    pip3 install niwidgets && \
    pip3 install --no-cache-dir notebook==5.* &&\
    ln -fs /usr/bin/python3 /usr/bin/python
