FROM ubuntu:16.04

MAINTAINER James Byars <jbyars4ku@gmail.com>

LABEL Description="Image with aws cli installed"

RUN apt-get update \
    && apt-get install -y \
		curl \
		git \
		zip \
		maven \
		openjdk-8-jdk \
		python \
		python-pip \
		openssl \
		vim \
		nmap \
		&& rm -r /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install awscli

WORKDIR /root/data

COPY . ./aec-infrastructure

RUN curl -O https://releases.hashicorp.com/terraform/0.10.8/terraform_0.10.8_linux_amd64.zip
RUN unzip terraform*zip
RUN echo 'export PATH=$PATH:/root/data' > /root/.bashrc

WORKDIR /root/data/aec-infrastructure
