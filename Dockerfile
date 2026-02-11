FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    software-properties-common \
    python3 \
    python3-pip \
    ssh \
    vim \
    sudo \
    iproute2 \
    htop \
    openssh-server

RUN useradd -m -s /bin/bash ansible \
    && echo "ansible:stepit" | chpasswd \
    && apt-get update && apt-get install -y \
    && echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ansible

RUN mkdir -p /home/ansible/.ssh \
    && chown -R ansible:ansible /home/ansible/.ssh \
    && chmod 700 /home/ansible/.ssh
RUN ssh-keygen -A

RUN sudo service ssh start

USER ansible

WORKDIR /home/ansible

CMD ["/bin/bash"]

