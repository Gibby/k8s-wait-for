FROM alpine:edge

WORKDIR /usr/local/bin
RUN apk add --update --no-cache ca-certificates curl jq && \
 curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
 curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"  && \
 echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c && \
 chmod +x /usr/local/bin/kubectl

COPY wait_for.sh /usr/local/bin/wait_for.sh

ENTRYPOINT ["wait_for.sh"]
