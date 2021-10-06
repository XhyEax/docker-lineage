FROM ubuntu:20.04
LABEL maintainer="Xhy <xhyeax@qq.com>"

# Environment variables
#######################

ENV SRC_DIR /srv/src
ENV CCACHE_DIR /srv/ccache

ENV DEBIAN_FRONTEND noninteractive
ENV USER root

# Configurable environment variables
####################################

# By default we want to use CCACHE, you can disable this
# WARNING: disabling this may slow down a lot your builds!
ENV USE_CCACHE 1

# ccache maximum size. It should be a number followed by an optional suffix: k,
# M, G, T (decimal), Ki, Mi, Gi or Ti (binary). The default suffix is G. Use 0
# for no limit.
ENV CCACHE_SIZE 50G

# We need to specify the ccache binary since it is no longer packaged along with AOSP
ENV CCACHE_EXEC /usr/bin/ccache

# Possible values: 'user|userdebug|eng', default is 'userdebug'
ENV BUILD_VARIANT 'userdebug'

# User identity
ENV USER_NAME 'LineageOS Buildbot'
ENV USER_MAIL 'lineageos-buildbot@docker.host'

# Provide root capabilities builtin inside the ROM (see http://lineageos.org/Update-and-Build-Prep/)
ENV WITH_SU false

# Create Volume entry points
############################
VOLUME $SRC_DIR
VOLUME $CCACHE_DIR

# Create missing directories
############################
RUN mkdir -p $SRC_DIR $CCACHE_DIR

# Install build dependencies
############################
RUN apt-get -qq update && \
      apt-get install -y bc bison bsdmainutils build-essential ccache cgpt clang \
      vim curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick \
      kmod lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool \
      libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 \
      libxml2-utils lsof lzop maven openjdk-8-jdk pngcrush procps \
      python rsync schedtool squashfs-tools wget xdelta3 xsltproc yasm zip \
      zlib1g-dev \
      && rm -rf /var/lib/apt/lists/*

RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo && \
      chmod a+x /usr/local/bin/repo

# Copy required files
#####################
COPY docker_entrypoint.sh /root/docker_entrypoint.sh

# Set the work directory
########################
WORKDIR $SRC_DIR

# Allow redirection of stdout to docker logs
############################################
RUN ln -sf /proc/1/fd/1 /var/log/docker.log

# Set the entry point to docker_entrypoint.sh
################################
ENTRYPOINT /root/docker_entrypoint.sh