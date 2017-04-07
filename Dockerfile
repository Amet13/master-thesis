FROM ubuntu
MAINTAINER Amet13 <admin@amet13.name>

ENV DIR /master-thesis
RUN mkdir $DIR

RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty multiverse" | tee -a /etc/apt/sources.list.d/multiverse.list && \
	echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

RUN apt update && \
	apt install -y git make wget apt-transport-https && \
	apt install -y texlive-base texlive-latex-extra texlive-xetex texlive-lang-cyrillic latexmk texlive-fonts-extra texlive-math-extra

RUN apt install -y --reinstall ttf-mscorefonts-installer

RUN wget -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/xits-math.otf && \
	fc-cache -f -v

VOLUME $DIR
WORKDIR $DIR