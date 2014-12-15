FROM ubuntu:14.04
MAINTAINER Matias Cascallares "matiascas@gmail.com"

ENV REFRESHED_AT 2014-12-15
ENV AGENT_PACKAGE mongodb-mms-automation-agent-manager_1.4.2.783-1_amd64.deb

RUN apt-get -qqy update

# dependecy required by MMS monitoring agent
RUN apt-get install -qqy libsasl2-2

# MMS automation
VOLUME /var/lib/mongodb-mms-automation
ADD setup/${AGENT_PACKAGE} /root/
RUN dpkg -i /root/${AGENT_PACKAGE}

# MongoDB data folder
VOLUME /data
RUN chown mongodb:mongodb /data

# default MMS automation port
EXPOSE 27000

ENTRYPOINT ["/opt/mongodb-mms-automation/bin/mongodb-mms-automation-agent"]