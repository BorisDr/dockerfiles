FROM alpine:latest
RUN cd tmp ;\
  wget -qO- "https://releases.hashicorp.com/terraform/0.14.4/terraform_0.14.4_linux_amd64.zip" -O /tmp/terraform_0.14.4_linux_amd64.zip ;\
  wget -qO- "https://github.com/gruntwork-io/terragrunt/releases/download/v0.27.2/terragrunt_linux_amd64" -O /tmp/terragrunt_linux_amd64 ;\
  unzip terraform_0.14.4_linux_amd64.zip ;\
  mv terraform /usr/local/bin/ ;\
  mv terragrunt_linux_amd64 /usr/local/bin/terragrunt ;\
  chmod 777 /usr/local/bin/terragrunt ;\
  cd /root ;\
  rm -rf tmp ;\
  apk add --no-cache \
    bash \
    git ;\
  addgroup -g 501 terraform ;\
  adduser -u 501 -G terraform -s /bin/bash -D terraform
USER terraform
WORKDIR /home/terraform