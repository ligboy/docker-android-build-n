FROM ubuntu:14.04

MAINTAINER Ligboy Liu "ligboy@gmail.com"

USER root
ENV USER root

RUN dpkg --add-architecture i386 && \
        apt-get update -qq
# Base Dependencies
RUN apt-get install -y wget python

# JDK
RUN apt-get install -y openjdk-7-jdk

# Building Required Packages
RUN apt-get install -y git-core gnupg flex bison gperf build-essential \
                         zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
                         lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
                         libgl1-mesa-dev libxml2-utils xsltproc unzip

RUN apt-get install -y python-networkx libnss-sss:i386

ENV JACK_SERVER_VM_ARGUMENTS "-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"

# Configuring USB Access
#RUN wget -S -O - http://source.android.com/source/51-android.rules | sed "s/<username>/$USER/" | tee >/dev/null /etc/udev/rules.d/51-android.rules; udevadm control --reload-rules

# Install repo tool
RUN mkdir /opt/tools
ENV PATH /opt/tools:$PATH
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /opt/tools/repo
RUN chmod a+x /opt/tools/repo

# Cleaning
RUN apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Go to workspace
RUN mkdir -p /var/workspace
WORKDIR /var/workspace