# CentOS with FSL. 
# Build via: docker build -f ./Dockerfile -t centos-fsl-5 .
FROM centos:latest

# Update the image with the latest packages 
RUN yum update -y; yum clean all

# Permit access to fsl installation script (must exist locally)
ADD ./fslinstaller.py /fslinstaller.py

# Add bc (necessary for some fsl packages)
RUN yum install -y bc

# Fsl-installer needs access to shell variable
ENV SHELL /bin/bash

# Install fsl to default dir
RUN echo -e "/usr/local" | python fslinstaller.py

# Set environment variables (run export not needed)
ENV FSLDIR /usr/local/fsl
ENV PATH ${FSLDIR}/bin:${PATH}

# FSL environment variables
ENV FSLOUTPUTTYPE NIFTI_GZ
ENV FSLTCLSH $FSLDIR/bin/fsltclsh
ENV FSLWISH=$FSLDIR/bin/fslwish
ENV FSLGECUDAQ=cuda.q


