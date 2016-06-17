FROM phusion/baseimage
MAINTAINER Anand J <anand.j@flipkart.com>

RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN sh -c "echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections"
RUN apt-get install -y oracle-java8-installer

CMD ["/sbin/my_init", "--enable-insecure-key"]
