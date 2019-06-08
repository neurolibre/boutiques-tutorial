FROM fedora:latest
RUN dnf update -y && dnf install singularity -y && \
    git+https://github.com/glatard/boutiques.git@singularity-fix#subdirectory=tools/python

