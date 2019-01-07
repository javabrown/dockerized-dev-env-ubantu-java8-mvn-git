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

ENV M2_HOME /opt/maven
ENV PATH  ${M2_HOME}/bin:${PATH}


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

# Create a volume
VOLUME /qlogic-projects
	
