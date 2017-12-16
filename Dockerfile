FROM postgres

RUN set -e && \
    apt-get update && \
    apt-get install -y zip unzip curl debconf-utils

# install SDK
RUN curl -s "https://get.sdkman.io" | bash && \
    source "$HOME/.sdkman/bin/sdkman-init.sh" && \
    sdk --version

#install java
RUN sdk install java 8u152-zulu && \
    java -version

#install gradle
RUN sdk install gradle 2.12 && \
    gradle -v

#install node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash && \
    apt-get install -y nodejs && \
    node -v && \
    npm -v && \

