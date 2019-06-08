FROM fedora:latest
RUN dnf update -y && dnf install singularity -y && \
    pip3 install boutiques
RUN (cd notebooks ; singularity pull --name mcin-docker-fsl-latest.simg docker://index.docker.io/mcin/docker-fsl:latest)

