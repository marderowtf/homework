#!/bin/bash

# Download and install Nginx Prometheus Exporter
wget https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v0.10.0/nginx-prometheus-exporter_0.10.0_linux_amd64.tar.gz
tar xzvf nginx-prometheus-exporter_0.10.0_linux_amd64.tar.gz
mv nginx-prometheus-exporter /usr/local/bin
useradd -r nginx_exporter
chown nginx_exporter:nginx_exporter /usr/local/bin/nginx-prometheus-exporter
cat > /etc/systemd/system/nginx_prometheus_exporter.service <<EOF
[Unit]
Description=NGINX Prometheus Exporter
After=network.target

[Service]
Type=simple
User=nginx_exporter
Group=nginx_exporter
ExecStart=/usr/local/bin/nginx-prometheus-exporter \
    -web.listen-address=192.168.8.12:9113 \
    -nginx.scrape-uri http://127.0.0.1:81/metrics

SyslogIdentifier=nginx_prometheus_exporter
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl start nginx_prometheus_exporter.service
systemctl enable nginx_prometheus_exporter.service