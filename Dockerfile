FROM ubuntu:20.04
MAINTAINER yarmy <bin@mlia.cn>
WORKDIR /root
# COPY /lantern/lantern-installer-64-bit.deb /root/lantern-installer-64-bit.deb
RUN apt-get update  && \
    apt-get -y install wget libappindicator3-1 && \
    wget https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb &&\
    dpkg -i ./lantern-installer-64-bit.deb && \
    apt-get -f install && \
    apt-get clean && \
    rm -rf ./lantern-installer-64-bit.deb ./lantern /var/cache/apt/* /var/lib/apt/lists/* && \
    mkdir /root/.lantern && \
    echo "localHTTPToken: vpn" > /root/settings.yaml

EXPOSE 19940/tcp 8181/tcp

ENTRYPOINT ["/usr/bin/lantern", "--configdir=/root", "--headless=true", "--proxyall=true", "--startup=false", "--clear-proxy-settings=false", "--addr=0.0.0.0:19940", "--uiaddr=0.0.0.0:8181"]
