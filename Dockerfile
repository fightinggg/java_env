FROM ubuntu:20.04
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install git pbuilder debhelper lsb-release fakeroot debian-archive-keyring debian-keyring -y
RUN apt-get install --reinstall ca-certificates -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository --update ppa:ubuntu-toolchain-r/test

RUN apt-get install openjdk-8-jdk maven -y


# SSH
RUN apt-get install ssh -y
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config; \
ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key -y; \
ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -y; \
ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -y; \
mkdir /run/sshd

RUN echo root:123456 | chpasswd


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"] 
