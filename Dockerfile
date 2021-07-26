FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && \
	apt-get install -qy sudo apt-transport-https apt-utils ca-certificates wget dirmngr gnupg software-properties-common \
	bash-completion asciidoctor -y && \
	useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod && \
	echo "PS1='\[\e]0;\u \w\a\]\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \\\$ '" >> /home/gitpod/.bashrc && \
	sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers && \
	echo "root:passwd" | chpasswd && \
	echo "gitpod:passwd" | chpasswd && \
	wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
	add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
	apt-get update && apt-get upgrade -y && \
	apt-get install -qy git nano screen zip unzip bash-completion build-essential ninja-build \
	htop vim jq less locales man-db nano software-properties-common time multitail lsof \
	ssl-cert fish zsh adoptopenjdk-16-hotspot adoptopenjdk-8-hotspot adoptopenjdk-11-hotspot && \
	apt-get clean && apt-get autoremove && \
	wget https://downloads.gradle-dn.com/distributions/gradle-7.1.1-bin.zip -P /tmp && \
    unzip -d /usr/share/tools /tmp/gradle-7.1.1-bin.zip && ln -s /usr/share/tools/gradle-7.1.1/ /usr/share/gradle && \
	echo 'export GRADLE_HOME=/usr/share/gradle/' > /etc/profile.d/gradle.sh && \
	echo 'export PATH=${GRADLE_HOME}/bin:${PATH}' >> /etc/profile.d/gradle.sh && \
	wget https://apache.website-solution.net/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.zip -P /tmp && \
	unzip -d /usr/share/tools /tmp/apache-maven-3.8.1-bin.zip && ln -s /usr/share/tools/apache-maven-3.8.1/ /usr/share/maven && \
	echo 'export export M2_HOME=/usr/share/maven/' > /etc/profile.d/maven.sh && \
	echo 'export MAVEN_HOME=/usr/share/maven/' >> /etc/profile.d/maven.sh && \
	echo 'export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh && \
	rm -rf /var/lib/apt/lists/* /tmp/*


USER gitpod
RUN sudo echo "Running 'sudo' for gitpod: success"