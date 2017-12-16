ENV POSTGRES_PASSWORD=postgres
#ENV PG_MAJOR=
#ENV PG_VERSION=

FROM postgres

SHELL ["/bin/bash", "-c", "source ~/.bashrc; "] 

RUN set -e && \
    apt-get update && \
    apt-get install -y zip unzip curl debconf-utils

# install SDK
RUN curl -s "https://get.sdkman.io" | bash

RUN sdk --version

#install java
RUN sdk install java 8u152-zulu && \
    java -version

#install gradle
RUN sdk install gradle 2.12 && \
    gradle -v

#install node
RUN curl -s "https://deb.nodesource.com/setup_8.x" | bash && \
    apt-get install -y nodejs && \
    node -v && \
    npm -v
