FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME       /usr/lib/jvm/java-8-oracle
ENV LANG            en_US.UTF-8
ENV LC_ALL          en_US.UTF-8

RUN apt-get update && \
  apt-get install -y --no-install-recommends locales && \
  locale-gen en_US.UTF-8 && \
  apt-get dist-upgrade -y && \
  apt-get --purge remove openjdk* && \
  echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
  apt-get update && \
  apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default && \
  apt-get clean all


# Installed Maven
RUN cd /opt && \
  wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
  tar -xvzf apache-maven-3.3.9-bin.tar.gz && \
  mv apache-maven-3.3.9 maven

# Installed Gradle
RUN apt-get update && \
  apt-get -y install gradle

ENV M2_HOME /opt/maven
ENV PATH  ${M2_HOME}/bin:${PATH}

# Install CURL
RUN apt-get update && \
    apt-get install -y curl

# Installed VI
RUN apt-get update && \
    apt-get install -y vim
	

# Install GCC
RUN apt-get update && \
    apt-get -y install gcc mono-mcs && \
	rm -rf /var/lib/apt/lists/*
	

# Install GIT
RUN apt-get update && \
    apt-get install -y git

# Install NodeJS
RUN apt-get update && \
    apt-get install -y nodejs
	
# Install NPM
RUN apt-get update && \
    apt-get install -y npm

# Install Ruby
RUN apt-get update && \
    apt-get install -y ruby
    
# Install Python
RUN apt-get update && \
    apt-get install -y python

# ----Google Cloud Lib Build Specific Installation --Begin--
# Install PIP 
RUN apt-get update && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py

# Install virtualenv 
RUN apt-get update && \
    pip install virtualenv

# Install Pipsi & Google Artman 
 RUN apt-get update && \
     curl https://raw.githubusercontent.com/cs01/pipsi/b90d627d39a03112b8ffa583880fab722b435b9b/get-pipsi.py | python  && \
     export PATH=/root/.local/bin:$PATH  && \
     apt-get update && \
     pipsi install googleapis-artman

# Configure Google API
RUN apt-get update && \
    git clone https://github.com/googleapis/googleapis.git googleapis/

# ----Google Cloud Lib Build Specific Installation --End-- 


# ---- Gapic Generator Configuration -begin- 
 RUN apt-get update && \
     curl -OL https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-linux-x86_64.zip  && \
     unzip protoc-3.3.0-linux-x86_64.zip -d protoc3  && \
     mv protoc3/bin/* /usr/local/bin/  && \
     mv protoc3/include/* /usr/local/include/  && \
     
     
# Installed Maven
RUN cd /opt && \
  wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
  tar -xvzf apache-maven-3.3.9-bin.tar.gz && \
  mv apache-maven-3.3.9 maven
  
 RUN apt-get update && \
     git clone https://github.com/googleapis/gapic-generator.git gapic-generator/
     #export GOOGLEAPIS_DIR=gapic-generator/  && \
# ---- Gapic Generator Configuration -end-
     
# Create a volume
VOLUME /qlogic-projects
	
