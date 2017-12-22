FROM ubuntu:16.04
MAINTAINER Limbus Medical Technologies GmbH <info@limbus-medtec.com>

ARG SONAR_PASSWORD=sonar
ARG AWS_SECRET_KEY=12345
ARG AWS_ACCESS_KEY=12345

ENV DISPLAY=:99
ENV PATH="/opt/gradle/gradle-2.12/bin:${PATH}"

USER root
SHELL ["/bin/bash", "-c"] 

RUN apt-get update && \
    apt-get install -y zip unzip curl debconf-utils wget locales software-properties-common sudo postgresql-client && \
    locale-gen en_US en_US.UTF-8 de_DE de_DE.UTF-8 && \
    dpkg-reconfigure locales

# install EC2 API Tools
RUN wget http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip && \
    unzip ec2-api-tools.zip && \
    mv ec2-api-tools-* /opt/ec2-api-tools

# install java
RUN apt-get install -y openjdk-8-jdk && \
    java -version
    
# install gradle    
RUN wget https://services.gradle.org/distributions/gradle-2.12-bin.zip && \
    mkdir /opt/gradle && \
    unzip gradle-2.12-bin.zip -d /opt/gradle && \
    gradle -v 

# install node
RUN curl -s "https://deb.nodesource.com/setup_8.x" | bash && \
    apt-get install -y nodejs && \
    node -v && \
    npm -v

# install browsers
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    apt-get update && \ 
    apt-get install -y google-chrome-stable firefox

# install xvfb
RUN apt-get install -y xvfb && \
    echo "[Unit]" > /etc/systemd/system/xvfb.service && \ 
    echo "Description=X Virtual Frame Buffer Service" >> /etc/systemd/system/xvfb.service && \ 
    echo "After=network.target" >> /etc/systemd/system/xvfb.service && \ 
    echo "[Service]" >> /etc/systemd/system/xvfb.service && \ 
    echo "ExecStart=/usr/bin/Xvfb :99 -ac -extension RANDR -screen 0 1920x1080x16" >> /etc/systemd/system/xvfb.service && \ 
    echo "[Install]" >> /etc/systemd/system/xvfb.service && \ 
    echo "WantedBy=multi-user.target" >> /etc/systemd/system/xvfb.service 
    
RUN systemctl enable /etc/systemd/system/xvfb.service
#RUN /etc/init.d/xvfb start

# install awscli    
RUN apt-get install -y awscli

# install bioinformatics tools
RUN apt-get install -y tabix=1.2.1-2ubuntu1 samtools=0.1.19-1ubuntu1 vcftools=0.1.14+dfsg-2

# install pandoc and imagemagick
RUN apt-get install -y pandoc imagemagick

# configure gradle
RUN mkdir -p ~/.gradle && \
    echo "sonar.jdbc.username=sonar" > ~/.gradle/gradle.properties && \
    echo "sonar.jdbc.password=$SONAR_PASSWORD" >> ~/.gradle/gradle.properties

# configure aws
RUN aws configure set aws_secret_access_key $AWS_SECRET_KEY && \
    aws configure set aws_access_key_id $AWS_ACCESS_KEY && \
    aws configure set default.region eu-west-1 && \
    aws configure set default.output json 

RUN locale-gen en_US en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8



