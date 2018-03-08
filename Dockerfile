FROM ubuntu:16.04

RUN apt-get update \
  && apt-get -y install git make nasm build-essential texlive-full noweb
