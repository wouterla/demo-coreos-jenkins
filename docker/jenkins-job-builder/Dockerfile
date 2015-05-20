FROM wouterla/docker-base
MAINTAINER Wouter Lagerweij <wouter@lagerweij.com>

RUN apt-get update && apt-get install -y\
  python-setuptools \
  python-dev \
  libyaml-dev \
  git \
  curl \
  python-pip \
  python-yaml

RUN git clone https://github.com/openstack-infra/jenkins-job-builder.git
WORKDIR jenkins-job-builder
RUN python setup.py install
RUN pip install pbr

ADD jobs /jobs
ADD config /config

VOLUME /jobs
VOLUME /config

CMD while ! curl --output /dev/null --silent --head --fail http://jenkins:8080; do sleep 1; echo -n .; done && jenkins-jobs --conf /config/jenkins_jobs.ini update /jobs
