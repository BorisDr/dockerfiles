FROM --platform=linux/x86_64 debian:bullseye-slim
RUN set -ex; \
  cd /tmp ;\
  apt-get update; \
  apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    bzr \
    jq \
    unzip \
    git-core ;\
  wget -qO- "https://releases.hashicorp.com/terraform/0.14.4/terraform_0.14.4_linux_amd64.zip" -O /tmp/terraform_0.14.4_linux_amd64.zip ;\
  wget -qO- "https://github.com/gruntwork-io/terragrunt/releases/download/v0.27.2/terragrunt_linux_amd64" -O /tmp/terragrunt_linux_amd64 ;\
  wget -qO- "https://storage.googleapis.com/kubernetes-release/release/v1.20.7/bin/linux/amd64/kubectl" -O /usr/local/bin/kubectl ;\
  wget -qO- "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -O "/tmp/awscliv2.zip"; \
  wget "https://get.helm.sh/helm-v3.7.2-linux-amd64.tar.gz" -O - | tar -xz ;\
  mv linux-amd64/helm /usr/bin/helm ;\
  unzip terraform_0.14.4_linux_amd64.zip ;\
  unzip awscliv2.zip; \
  mv terraform /usr/local/bin/ ;\
  mv terragrunt_linux_amd64 /usr/local/bin/terragrunt ;\
  chmod 777 /usr/local/bin/terragrunt ;\
  chmod 777 /usr/local/bin/kubectl ;\
  /tmp/aws/install; \
  cd /root ;\
  rm -rf /var/lib/apt/lists/* ;\
  rm -rf tmp ;\
  groupadd --gid 501 terraform ;\
  useradd --uid 501 --gid terraform --shell /bin/bash --create-home terraform ;\
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
