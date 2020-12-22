FROM debian:buster as builder
RUN set -ex; \
    { \
      echo -n 'deb http://deb.debian.org/debian buster main' ; \
      echo -n 'deb-src http://deb.debian.org/debian buster main' ; \
      echo -n 'deb http://security.debian.org/debian-security buster/updates main' ; \
      echo -n 'deb-src http://security.debian.org/debian-security buster/updates main' ; \
      echo -n 'deb http://deb.debian.org/debian buster-updates main'; \
      echo -n 'deb-src http://deb.debian.org/debian buster-updates main' ; \
    } | tee /etc/apt/sources.list; \
    apt-get update; \
    apt-get install -y build-essential \
    git \
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
        groff \
        traceroute \
        less \
        jq \
        netcat \
        openssh-client; \
	rm -rf /var/lib/apt/lists/*; \
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; \
  curl "https://releases.hashicorp.com/vault/1.6.0/vault_1.6.0_linux_amd64.zip" -o "vault_1.6.0_linux_amd64.zip"; \
  wget http://packages.azlux.fr/debian/pool/main/g/gping/gping_1.2.0-post_amd64.deb; \
  dpkg -i gping_1.2.0-post_amd64.deb; \
  rm -f gping_1.2.0-post_amd64.deb; \
  unzip awscliv2.zip; \
  unzip vault_1.6.0_linux_amd64.zip; \
  mv vault /usr/local/bin/vault; \
  rm -f vault_1.6.0_linux_amd64.zip; \
  ./aws/install; \
  rm -rf aws awscliv2.zip; \
  wget -qO- "https://storage.googleapis.com/kubernetes-release/release/v1.17.6/bin/linux/amd64/kubectl" -O /usr/local/bin/kubectl ;\
  chmod 777 /usr/local/bin/kubectl; \
  mkdir ~/.aws; \
  echo "PS1='\w\$ '" >> /root/.bashrc; \
  echo "[default]" >> /root/.aws/config; \
  echo "region = us-east-1" >> /root/.aws/config
