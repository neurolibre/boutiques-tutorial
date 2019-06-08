FROM fedora:latest
RUN dnf update -y && dnf install singularity -y && \
    pip install git+https://github.com/glatard/boutiques.git@singularity-fix#subdirectory=tools/python
RUN (cd notebooks ; singularity pull --name mcin-docker-fsl-latest.simg docker://index.docker.io/mcin/docker-fsl:latest)

