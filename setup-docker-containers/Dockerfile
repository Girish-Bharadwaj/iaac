FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    useradd -m -s /bin/bash ansible && \
    echo 'ansible:ansible' | chpasswd && \
    mkdir /var/run/sshd && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

EXPOSE 22

CMD ["service", "ssh", "start", "-D"]