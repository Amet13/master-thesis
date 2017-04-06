FROM ubuntu
MAINTAINER Amet13 <admin@amet13.name>

RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty multiverse" | tee -a /etc/apt/sources.list.d/multiverse.list && \
	echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

RUN apt update && \
	apt install -y git make wget apt-transport-https && \
	apt install -y texlive-base texlive-latex-extra texlive-xetex texlive-lang-cyrillic latexmk texlive-fonts-extra texlive-math-extra

RUN apt install -y --reinstall ttf-mscorefonts-installer

RUN git clone --recursive https://github.com/Amet13/master-thesis && \
	wget -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/xits-math.otf && \
	fc-cache -f -v

RUN cd /master-thesis/ && \
	make build