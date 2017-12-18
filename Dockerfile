FROM ubuntu:16.04
MAINTAINER Limbus Medical Technologies GmbH <info@limbus-medtec.com>

ARG POSTGRES_PASSWORD=postgres
ARG SONAR_PASSWORD=sonar
ARG AWS_SECRET_KEY=12345
ARG AWS_ACCESS_KEY=12345

ENV LVMS_DATABASE_USERNAME=ci
ENV LVMS_DATABASE_PASSWORD=$POSTGRES_PASSWORD 
ENV DISPLAY=:99

USER root
SHELL ["/bin/bash", "-c"] 

RUN apt-get update && \
    apt-get install -y zip unzip curl debconf-utils wget locales software-properties-common sudo libreadline6 && \
    locale-gen en_US en_US.UTF-8 de_DE de_DE.UTF-8 && \
    dpkg-reconfigure locales

# install postgreSQL
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list && \
    wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add - && \
    apt-get update && \
    apt-get install -y postgresql-9.6 postgresql-client-9.6
    
USER postgres
RUN /etc/init.d/postgresql start &&\
    psql -c "CREATE USER ci WITH SUPERUSER PASSWORD '$POSTGRES_PASSWORD'" &&\
    createdb -O ci lvmtest

USER root
#RUN PGPASSWORD=$POSTGRES_PASSWORD psql -h 127.0.0.1 -U ci -d lvmtest -c "SELECT 'Connection to postgreSQL successful'"


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
    export PATH=$PATH:/opt/gradle/gradle-2.12/bin && \
    gradle -v && \
    echo "export PATH=$PATH:/opt/gradle/gradle-2.12/bin" >> /etc/.profile 

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
RUN /etc/init.d/xvfb start

# install awscli    
RUN apt-get install -y awscli

# install bioinformatics tools
RUN apt-get install -y tabix=1.2.1-2ubuntu1 samtools=0.1.19-1ubuntu1 vcftools=0.1.14+dfsg-2

# install pandoc and imagemagick
RUN apt-get install -y pandoc imagemagick

# configure aws
RUN aws configure set aws_secret_access_key $AWS_SECRET_KEY && \
    aws configure set aws_access_key_id $AWS_ACCESS_KEY && \
    aws configure set default.region eu-west-1 && \
    aws configure set default.output json 
# && \
#    aws s3 ls s3://roland-develop-limbus-medtec-test-filebucket

# create ci user and configure gradle
RUN useradd -m ci

# configure gradle
USER ci
RUN echo "sonar.jdbc.username=sonar" > /home/ci/.gradle/gradle.properties && \
    echo "sonar.jdbc.password=$SONAR_PASSWORD"
USER root

RUN echo $SONAR_PASSWORD && echo $POSTGRES_PASSWORD
