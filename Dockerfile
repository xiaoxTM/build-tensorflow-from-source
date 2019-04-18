FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
ENV DEBIAN_FRONTEND noninteractive
LABEL maintainer "Renwu Gao <gilyou.public@gmail.com>"

RUN apt-get update && apt-get install -y python3-dev python3-pip \
    openjdk-8-jdk vim git emacs build-essential g++ graphviz curl \
    --no-install-recommends

RUN pip3 install -U pip3 six numpy wheel setuptools mock 
 && pip3 install -U keras_applications >= 1.0.6 \
     keras_preprocessing >= 1.0.6 \
     absl-py >= 0.7.0 \
     astor >= 0.6.0
     gast >= 0.2.0\
     google_pasta >= 0.1.2 \
     numpy >= 1.14.5, < 2.0 \
     siz >= 1.10.0 \
     protobuf >= 3.6.1 \
     tensorboard >= 1.13.0, < 1.14.0 \
     tensorflow_estimator >= 1.13.0rc0, < 1.14.0rc0 \
     termcolor >= 1.1.0 \
     wrapt > 1.11.1 \
     --no-deps
 && pip3 install -U --no-deps
 && echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
 && curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
 && apt-get update
 && apt-get install -y bazel --no-install-recommends
 && apt-get install --only-upgrade bazel
 && apt-get clean
 && rm -rf /var/lib/apt/lists/*
 
 WORKDIR /
 RUN git clone https://github.com/tensorflow/tensorflow.git
  && cd tensorflow
  && git checkout r2.0
  && ./configure
