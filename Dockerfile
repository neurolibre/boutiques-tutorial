# This container is built in base-image and pushed manually
# 
FROM boutiques/boutiques-tutorial:94ba8c7

# Binder stuff
RUN useradd -d /home/boutiques -u 1000 boutiques &&\
    mkdir /home/boutiques/notebooks && mkdir -p /home/boutiques/.cache/boutiques
COPY notebooks /home/boutiques/notebooks
COPY base-image/entrypoint /

# Tampering the cache so that descriptor runs without a container image
COPY base-image/zenodo-1482743.json base-image/zenodo-3240521.json /home/boutiques/.cache/boutiques/
RUN chown -R boutiques:boutiques /home/boutiques
USER boutiques
WORKDIR /home/boutiques
ENTRYPOINT ["/entrypoint"]
