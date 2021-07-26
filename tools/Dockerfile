FROM debian:buster as builder
RUN set -ex; \
    { \
      echo -n 'deb http://deb.debian.org/debian buster main\n' ; \
      echo -n 'deb-src http://deb.debian.org/debian buster main\n' ; \
      echo -n 'deb http://security.debian.org/debian-security buster/updates main\n' ; \
      echo -n 'deb-src http://security.debian.org/debian-security buster/updates main\n' ; \
      echo -n 'deb http://deb.debian.org/debian buster-updates main\n'; \
      echo -n 'deb-src http://deb.debian.org/debian buster-updates main\n' ; \
    } | tee /etc/apt/sources.list; \
    # curl https://baltocdn.com/helm/signing.asc | apt-key add - ;\
    apt-get update; \
    apt-get install -y git \
	    build-essential \
	    zlib1g-dev ; \
    git clone https://github.com/rbsec/sslscan.git /tmp/sslscan ;\
    cd /tmp/sslscan ;\
    make static

FROM debian:buster
LABEL maintainer="Boris <borisdr@gmail.com>"
WORKDIR /root
COPY README /root/
COPY --from=builder /tmp/sslscan/sslscan /usr/local/bin/sslscan
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        git \
        unzip \
        dnsutils \
        redis-tools \
        groff \
        traceroute \
        kafkacat \
        less \
        net-tools \
        jq \
        netcat \
        tcpdump \
        openssh-client; \
	rm -rf /var/lib/apt/lists/*; \
	mkdir tmp ;\
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; \
  curl "https://releases.hashicorp.com/vault/1.7.1/vault_1.7.1_linux_amd64.zip" -o "vault_1.7.1_linux_amd64.zip"; \
  wget -qO- "https://get.helm.sh/helm-v3.5.4-linux-amd64.tar.gz" | tar xz -C tmp/ ;\
  wget -qO- "https://repo.mongodb.org/apt/debian/dists/buster/mongodb-org/4.4/main/binary-amd64/mongodb-org-shell_4.4.4_amd64.deb" -O /tmp/mongodb-org-shell_4.4.4_amd64.deb ;\
  wget -qO- "https://repo.mongodb.org/apt/debian/dists/buster/mongodb-org/4.4/main/binary-amd64/mongodb-org-tools_4.4.4_amd64.deb" -O /tmp/mongodb-org-tools_4.4.4_amd64.deb ;\
  wget -qO- "https://repo.mongodb.org/apt/debian/dists/buster/mongodb-org/4.4/main/binary-amd64/mongodb-database-tools_100.3.0_amd64.deb" -O /tmp/mongodb-database-tools_100.3.0_amd64.deb ;\
  wget -qO- "https://repo.mongodb.org/apt/debian/dists/buster/mongodb-org/4.4/main/binary-amd64/mongodb-org-database-tools-extra_4.4.4_amd64.deb" -O /tmp/mongodb-org-database-tools-extra_4.4.4_amd64.deb ;\
  dpkg -i /tmp/mongodb-database-tools_100.3.0_amd64.deb ;\
  dpkg -i /tmp/mongodb-org-database-tools-extra_4.4.4_amd64.deb ;\
  dpkg -i /tmp/mongodb-org-shell_4.4.4_amd64.deb ;\
  dpkg -i /tmp/mongodb-org-tools_4.4.4_amd64.deb ;\
  mv tmp/linux-amd64/helm /usr/local/bin/ ;\
  rm -rf tmp ;\
  unzip awscliv2.zip; \
  unzip vault_1.7.1_linux_amd64.zip; \
  mv vault /usr/local/bin/vault; \
  rm -f vault_1.7.1_linux_amd64.zip; \
  ./aws/install; \
  rm -rf aws awscliv2.zip; \
  wget -qO- "https://storage.googleapis.com/kubernetes-release/release/v1.19.8/bin/linux/amd64/kubectl" -O /usr/local/bin/kubectl ;\
  chmod 777 /usr/local/bin/kubectl; \
  wget -qO- "https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64" -O /usr/local/bin/hey ;\
  chmod 777 /usr/local/bin/hey; \
  mkdir ~/.aws; \
  echo "PS1='\w\$ '" >> /root/.bashrc; \
  echo "[default]" >> /root/.aws/config; \
  echo "region = us-east-1" >> /root/.aws/config
