FROM ubuntu:18.04
LABEL maintainer="Amet13 <admin@amet13.name>"

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV DIR /master-thesis

RUN mkdir $DIR
RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections
RUN apt update && \
    apt install -y wget \
        git \
        make \
        apt-transport-https \
        unzip && \
    apt install -y texlive-base \
        texlive-latex-extra \
        texlive-xetex \
        texlive-lang-cyrillic \
        texlive-fonts-extra \
        texlive-science \
        texlive-latex-recommended \
        latexmk

# Times New Roman and other fonts
RUN apt install -y --reinstall ttf-mscorefonts-installer && \
    wget -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/XITSMath-Regular.otf && \
    wget http://bbgentoo.ilb.ru/distfiles/PTSansOFL.zip && \
    wget http://bbgentoo.ilb.ru/distfiles/PTMonoOFL.zip && \
    unzip -o PTSansOFL.zip -d /usr/share/fonts/ && unzip -o PTMonoOFL.zip -d /usr/share/fonts/ && \
    rm -f PTSansOFL.zip PTMonoOFL.zip && \
    fc-cache -f -v

VOLUME $DIR
WORKDIR $DIR
