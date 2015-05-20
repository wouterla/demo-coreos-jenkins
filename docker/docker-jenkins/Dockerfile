FROM wouterla/docker-base
MAINTAINER Wouter Lagerweij <wouter@lagerweij.com>

# Install Fleet
WORKDIR /tmp
ENV FLEET_VER=v0.10.1
RUN curl -L https://github.com/coreos/fleet/releases/download/$FLEET_VER/fleet-$FLEET_VER-linux-amd64.tar.gz -o fleet-$FLEET_VER-linux-amd64.tar.gz
RUN tar xzf fleet-$FLEET_VER-linux-amd64.tar.gz
RUN cp fleet-$FLEET_VER-linux-amd64/fleetctl /usr/bin/fleetctl
RUN rm -rf fleet-$FLEET_VER-linux-amd64*

# Install etcdctl
ENV ETCD_VER=v2.0.11
RUN curl -L  https://github.com/coreos/etcd/releases/download/$ETCD_VER/etcd-$ETCD_VER-linux-amd64.tar.gz -o etcd-$ETCD_VER-linux-amd64.tar.gz

RUN tar xzf etcd-$ETCD_VER-linux-amd64.tar.gz
RUN cp -f etcd-$ETCD_VER-linux-amd64/etcdctl /usr/bin
RUN rm -rf etcd-$ETCD_VER-linux-amd64*

# Install Jenkins
ENV JENKINS_HOME /var/lib/jenkins
ENV TEMP_JENKINS_CONF /tmp/jenkins
ENV JENKINS_UC http://ftp.nluug.nl/programming/jenkins

RUN curl -L ${JENKINS_UC}/war/latest/jenkins.war -o /opt/jenkins.war

# Add configuration for jenkins and plugins
RUN mkdir -p $JENKINS_HOME
RUN mkdir -p $TEMP_JENKINS_CONF

# Install plugins from plugins.txt
RUN mkdir -p $TEMP_JENKINS_CONF/plugins
ADD plugins.txt plugins.txt
RUN cat plugins.txt | while read line; do \
      plugin_name=$(echo $line | cut -f1 -d:); \
      plugin_version=$(echo $line | cut -f2 -d:); \
      curl -L ${JENKINS_UC}/plugins/${plugin_name}/${plugin_version}/${plugin_name}.hpi -o ${TEMP_JENKINS_CONF}/plugins/${plugin_name}.hpi; \
    done

# Expose the jenkins dir as a volume
VOLUME /var/lib/jenkins

# Add configuration files
ADD jenkins_home $TEMP_JENKINS_CONF/
ADD jenkins_home/.ssh /root/.ssh/
ADD jenkins_home/.dockercfg /root/
ADD bin/* /usr/bin/

EXPOSE 8080
ENTRYPOINT cp -ra $TEMP_JENKINS_CONF/* $JENKINS_HOME/ && java -jar /opt/jenkins.war
