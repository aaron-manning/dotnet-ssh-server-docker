FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /source

RUN apt-get update && apt-get install -y openssh-server sudo nano
RUN dotnet tool install -g dotnet-ef

ARG ASPNETCORE_ENVIRONMENT
ARG SSH_PORT=222
# connect as root
ARG SSH_PASSWORD

RUN echo "Env: $ASPNETCORE_ENVIRONMENT"

# update password
RUN echo "root:$SSH_PASSWORD" | chpasswd

ENV PATH $PATH:/root/.dotnet/tools
# required to get dotnet ef command working when SSD'd in
RUN echo 'export PATH=$PATH:/root/.dotnet/tools' >> /root/.bashrc
RUN dotnet ef --version

RUN echo "Port $SSH_PORT" > /etc/ssh/sshd_config.d/dev.conf
RUN sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE $SSH_PORT

RUN mkdir /var/run/sshd

CMD ["/usr/sbin/sshd", "-D"]