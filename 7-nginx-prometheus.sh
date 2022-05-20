#!/bin/bash

# Download and install Nginx Prometheus Exporter
wget https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v0.10.0/nginx-prometheus-exporter_0.10.0_linux_amd64.tar.gz
tar xzvf nginx-prometheus-exporter_0.10.0_linux_amd64.tar.gz
mv nginx-prometheus-exporter /usr/local/bin
useradd -r nginx_exporter
cp /tmp/homework/node_exporter.service /etc/systemd/system/
systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter