#!/bin/bash

# Install Prometheus, Node Exporter, Grafana
cd ~
# Node Exporter
# Create User
useradd --no-create-home --shell /bin/false node_exporter
# Download Node Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
tar xzvf node_exporter-*.t*gz
# Copy Files Node Exporter
cp node_exporter-*.linux-amd64/node_exporter /usr/local/bin
chown node_exporter: /usr/local/bin/node_exporter
# Config Node Exporter
cat > /etc/systemd/system/node_exporter.service <<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
EOF
#systemctl daemon-reload
#systemctl start node_exporter
#systemctl enable node_exporter
# Prometheus
# Create User
useradd --no-create-home --shell /usr/sbin/nologin prometheus
# Download Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.34.0/prometheus-2.34.0.linux-amd64.tar.gz
tar xzvf prometheus-*.t*gz
# Create Directory
mkdir {/etc/,/var/lib/}prometheus
# Copy Files
cp -vi prometheus-*.linux-amd64/prom{etheus,tool} /usr/local/bin
cp -rvi prometheus-*.linux-amd64/{console{_libraries,s},prometheus.yml} /etc/prometheus/
chown -Rv prometheus: /usr/local/bin/prom{etheus,tool} /etc/prometheus/ /var/lib/prometheus/
# Config Prometheus
cat > /etc/prometheus/prometheus.yml <<EOF
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
    - targets: ['localhost:9090']
  - job_name: 'node_exporter' # <-- Добавили
    static_configs:
    - targets: ['localhost:9100']
  - job_name: 'nginx'
    static_configs:
    - targets: ['10.67.14.57:9113']
EOF
cat > /etc/systemd/system/prometheus.service <<EOF
[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus
--config.file /etc/prometheus/prometheus.yml \
--storage.tsdb.path /var/lib/prometheus/ \
--web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries
ExecReload=/bin/kill -HUP $MAINPID

[Install]
WantedBy=multi-user.target
EOF
#systemctl daemon-reload
#systemctl start prometheus
#systemctl enable prometheus
# Grafana
# Create Repo
cat > /etc/yum.repos.d/grafana.repo <<EOF
[grafana]
name=grafana
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
EOF
# Install
yum -y install grafana
# Start
systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter
systemctl start prometheus
systemctl enable prometheus
systemctl start grafana-server
systemctl enable grafana-server
systemctl disable --now firewalld