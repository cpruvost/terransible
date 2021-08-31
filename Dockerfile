# CPRUVOST DOCKERFILE PROJECT
# --------------------------
#
# Dockerfile template for all tools needed in Infra As Code Automation For Minecraft Server On OCI
#
# Usefull Tools Last version : jq, unzip, curl, wget
# Terraform
# OCI CLI
# OpenJdk
# Vault
# Ansible
# OCI
# OCI Ansible Collection
#
# TO DO LIST : put variables for version of products.
#
# HOW TO BUILD THIS IMAGE
# -----------------------
#
# Run:
#      $ docker build -t yourgitaccount/terransible .
#
#
FROM oraclelinux:8-slim

ARG tfrelease=0
ARG tfupdate=5
ARG vaultrelease=8
ARG vaultupdate=2
ARG javarelease=8
ARG javaupdate=0

RUN mkdir /devops
WORKDIR /devops

#Yum Back
RUN microdnf install yum

#Usefull Tools Last Version
RUN yum -y install jq unzip curl wget

#Terraform
RUN wget https://releases.hashicorp.com/terraform/1.${tfrelease}.${tfupdate}/terraform_1.${tfrelease}.${tfupdate}_linux_amd64.zip && \
    unzip ./terraform_1.${tfrelease}.${tfupdate}_linux_amd64.zip -d /usr/local/bin/ && \
    rm ./terraform_1.${tfrelease}.${tfupdate}_linux_amd64.zip

#Vault
RUN mkdir vault && \
    wget https://releases.hashicorp.com/vault/1.${vaultrelease}.${vaultupdate}/vault_1.${vaultrelease}.${vaultupdate}_linux_amd64.zip && \
    unzip vault_1.${vaultrelease}.${vaultupdate}_linux_amd64.zip -d ./vault && \
    rm -rf vault_1.${vaultrelease}.${vaultupdate}_linux_amd64.zip

#Open Jdk8
RUN yum -y install java-1.${javarelease}.${javaupdate}-openjdk-devel && rm -rf /var/cache/yum
ENV JAVA_HOME /usr/lib/jvm/java-openjdk

#Install Python
RUN dnf -y module install python38

#Enable EPEL
RUN dnf -y install oracle-epel-release-el8

#Ansible
RUN dnf -y install ansible ansible-doc

#Enable dev package
RUN dnf -y install oraclelinux-developer-release-el8

#OCI CLI
RUN dnf -y install python36-oci-cli

#Ansible OCI Collection
RUN ansible-galaxy collection install -f oracle.oci

#ENV PATH
ENV PATH=$PATH:/devops/vault

COPY showtoolsversion.sh .
RUN  chmod +x showtoolsversion.sh

CMD ["./showtoolsversion.sh"]
