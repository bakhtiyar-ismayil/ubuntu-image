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

RUN apt update && apt install -y curl docker.io 
RUN curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
RUN chmod +x ./kind
RUN mv ./kind /usr/local/bin/kind

RUN useradd -m -s /bin/bash ansible \
    && echo "ansible:ansible" | chpasswd \
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

