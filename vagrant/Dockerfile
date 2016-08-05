FROM phusion/baseimage
MAINTAINER Anand J <anand.j@flipkart.com>

RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN echo "deb http://www.apache.org/dist/cassandra/debian 21x main" >> /etc/apt/sources.list.d/my.list 
RUN echo "deb-src http://www.apache.org/dist/cassandra/debian 21x main" >> /etc/apt/sources.list.d/my.list 

RUN gpg --keyserver pgp.mit.edu --recv-keys F758CE318D77295D
RUN gpg --export --armor F758CE318D77295D | apt-key add -
RUN gpg --keyserver pgp.mit.edu --recv-keys 2B5C1B00
RUN gpg --export --armor 2B5C1B00 | apt-key add -
RUN gpg --keyserver pgp.mit.edu --recv-keys 0353B12C
RUN gpg --export --armor 0353B12C | apt-key add -

RUN add-apt-repository 'deb http://archive.ubuntu.com/ubuntu trusty universe'
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN sh -c "echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections"
RUN export DEBIAN_FRONTEND="noninteractive"
RUN apt-get install -y --force-yes oracle-java8-installer mysql-server-5.6 cassandra telnet tcpdump nmap

CMD ["/sbin/my_init", "--enable-insecure-key"]
