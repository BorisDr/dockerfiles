FROM debian:trixie AS builder
RUN set -ex; \
    apt-get update; \
    apt-get install -y git \
	    build-essential \
      wget \
	    zlib1g-dev ; \
    git clone https://github.com/rbsec/sslscan.git /tmp/sslscan ;\
    cd /tmp/sslscan ;\
    make static; \
    mkdir /tmp/redis ;\
    wget -qO- "http://download.redis.io/redis-stable.tar.gz" | tar xz -C /tmp/redis/ ;\
    cd /tmp/redis/redis-stable ;\
    make

FROM debian:trixie-slim
LABEL maintainer="Boris <borisdr@gmail.com>"
WORKDIR /root
# COPY README /root/
COPY --from=builder /tmp/sslscan/sslscan /usr/local/bin/sslscan
COPY --from=builder /tmp/redis/redis-stable/src/redis-cli /usr/local/bin/redis-cli
# COPY --from=builder /tmp/redis/redis-6.2.12/src/redis-benchmark /usr/local/bin/redis-benchmark
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
        vim-tiny \
        traceroute \
        less \
        net-tools \
        jq \
        netcat-traditional \
        tcpdump \
        openssh-client; \
    mkdir -p tmp; \
    curl -sSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; \
    wget -qO- "https://github.com/fullstorydev/grpcurl/releases/download/v1.8.7/grpcurl_1.8.7_linux_x86_64.tar.gz" | tar xz -C tmp/; \
    mv tmp/grpcurl /usr/local/bin/; \
    rm -rf tmp; \
    unzip -q awscliv2.zip; \
    ./aws/install; \
    rm -rf aws awscliv2.zip; \
    rm -rf /usr/local/aws-cli/v2/current/dist/awscli/examples; \
    mkdir -p ~/.aws; \
    echo "PS1='\w\$ '" >> /root/.bashrc; \
    echo "[default]" >> /root/.aws/config; \
    echo "region = us-east-1" >> /root/.aws/config; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
