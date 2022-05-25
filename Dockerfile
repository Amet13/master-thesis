# syntax=docker/dockerfile:1
FROM ubuntu:22.04
LABEL maintainer="Amet13 <admin@amet13.name>"
LABEL org.opencontainers.image.description "https://github.com/Amet13/master-thesis"

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV DIR /master-thesis

RUN mkdir $DIR && \
    echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections

RUN apt update && \
    apt install --no-install-recommends -y \
        wget \
        git \
        make \
        apt-transport-https \
        unzip && \
    apt install --no-install-recommends -y \
        texlive-base \
        texlive-latex-extra \
        texlive-xetex \
        texlive-lang-cyrillic \
        texlive-fonts-extra \
        texlive-science \
        texlive-latex-recommended \
        latexmk

# Times New Roman and other fonts
RUN apt install --no-install-recommends --reinstall -y \
    ttf-mscorefonts-installer \
    fonts-freefont-ttf \
    fontconfig && \
    wget -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/XITSMath-Regular.otf && \
    wget https://ftp.tw.freebsd.org/distfiles/xorg/font/PTSansOFL.zip && \
    wget https://ftp.tw.freebsd.org/distfiles/xorg/font/PTMonoOFL.zip && \
    unzip -o PTSansOFL.zip -d /usr/share/fonts/ && unzip -o PTMonoOFL.zip -d /usr/share/fonts/ && \
    rm -f PTSansOFL.zip PTMonoOFL.zip && \
    fc-cache -f -v

VOLUME $DIR
WORKDIR $DIR
