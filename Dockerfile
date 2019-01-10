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

#Install pipsi
RUN apt-get update && \ 
    curl https://raw.githubusercontent.com/cs01/pipsi/b90d627d39a03112b8ffa583880fab722b435b9b/get-pipsi.py | python  && \ 
	mv /root/.local/bin/* /usr/local/bin/ 

# ----Google Cloud Lib Build Specific Installation --End-- 


# ---- Gapic Generator Configuration -begin- 

RUN echo >***Installing protoc
RUN apt-get update && \
  wget https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-linux-x86_64.zip && \
  unzip protoc-3.3.0-linux-x86_64.zip -d protoc3 && \
  mv protoc3/bin/* /usr/local/bin/ && \
  mv protoc3/include/* /usr/local/include/
 
ENV PROTOC_INCLUDE_DIR /usr/local/include/



RUN echo >***Installing Artman***
RUN apt-get update && \ 
    pipsi install googleapis-artman &&\ 
	mv /root/.local/bin/artman /usr/local/bin/ && \
    mv /root/.local/bin/configure-artman /usr/local/bin/ && \
	mv /root/.local/bin/start-artman-conductor /usr/local/bin/ && \
	mv /root/.local/bin/smoketest_artman.py /usr/local/bin/


#  discovery-artifact-manager/generate_library
RUN pip install google-apis-client-generator


# Cloned gapic-generator
#RUN apt-get update && \
#    git clone https://github.com/googleapis/gapic-generator.git gapic-generator/
 

# Cloned googleapis
#RUN apt-get update && \
#    git clone https://github.com/googleapis/googleapis.git googleapis/

	
	
#RUN apt-get update && \
#    cd /gapic-generator/ && \

#RUN apt-get update && \
#    export GOOGLEAPIS_DIR=/gapic-generator/

#ENV GAPIC_GENERATOR_DIR googleapis/gapic-generator
#ENV GOOGLEAPIS_DIR googleapis/googleapis
#	 
# ---- Gapic Generator Configuration -end-


#**Installing Doker | docker demon wont work, need fix for docker-in-docker
RUN apt-get update && \
apt-get -y install apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
apt-get update && \
apt-get -y install docker-ce


# Install Bazel
 RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list && \
     curl https://bazel.build/bazel-release.pub.gpg | apt-key add - && \
     apt-get update && \
     apt-get -y install bazel
	 
     
# Create a volume
VOLUME /qlogic-projects


RUN echo ***********DONE************
