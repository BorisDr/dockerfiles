FROM alpine:latest
RUN cd tmp ;\
  wget -qO- "https://releases.hashicorp.com/terraform/0.14.4/terraform_0.14.4_linux_amd64.zip" -O /tmp/terraform_0.14.4_linux_amd64.zip ;\
  wget -qO- "https://github.com/gruntwork-io/terragrunt/releases/download/v0.27.2/terragrunt_linux_amd64" -O /tmp/terragrunt_linux_amd64 ;\
  wget -qO- "https://storage.googleapis.com/kubernetes-release/release/v1.20.7/bin/linux/amd64/kubectl" -O /usr/local/bin/kubectl ;\
  wget "https://get.helm.sh/helm-v3.7.2-linux-amd64.tar.gz" -O - | tar -xz ;\
  mv linux-amd64/helm /usr/bin/helm ;\
  unzip terraform_0.14.4_linux_amd64.zip ;\
  unzip vault_1.7.1_linux_amd64.zip ;\
  mv terraform /usr/local/bin/ ;\
  mv terragrunt_linux_amd64 /usr/local/bin/terragrunt ;\
  chmod 777 /usr/local/bin/terragrunt ;\
  chmod 777 /usr/local/bin/kubectl ;\
  cd /root ;\
  rm -rf tmp ;\
  apk add --no-cache \
    bash \
    git ;\
  addgroup -g 501 terraform ;\
  adduser -u 501 -G terraform -s /bin/bash -D terraform ;\
  { \
      echo 'alias tf="terraform"' ;\
      echo 'alias tfvl="terraform validate"' ;\
      echo 'alias tfin="terraform init"' ;\
      echo 'alias tfpl="terraform plan"' ;\
      echo 'alias tfapl="terraform apply -auto-approve"' ;\
      echo 'alias tfdes="terraform destroy -auto-approve"' ;\
  } | tee /home/terraform/.bashrc; \
  chown terraform:terraform /home/terraform/.bashrc
USER terraform
WORKDIR /home/terraform