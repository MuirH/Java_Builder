FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && \
	apt-get install apt-transport-https ca-certificates wget dirmngr gnupg software-properties-common \
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
	sudo htop vim jq less locales man-db nano software-properties-common time multitail lsof \
	ssl-cert fish zsh adoptopenjdk-16-hotspot adoptopenjdk-8-hotspot adoptopenjdk-11-hotspot && \
	apt-get clean && apt-get autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/*

USER gitpod
RUN sudo echo "Running 'sudo' for gitpod: success"