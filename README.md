# Dockerized dev env on Ubuntu 16.04 LTS
##### Dockerized dev env with tools e.g. java 8, maven, git, mysql, node etc on Ubuntu 16.04 LTS

###### Shared volume:
	> c:/projects:/projects)


#### Build/Run Docker Image
	$ docker build -t rk-ubantu-env .
  
#### Build/Run Docker Image
	$ docker run -v c:/projects:/projects -ti rk-ubantu-env 
