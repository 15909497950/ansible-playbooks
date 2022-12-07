#!/bin/bash

#下载 wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
mkdir -p {{ data_path }}
cd {{ data_path }}/soft/
tar -xf {{ node_name }} -C {{ data_path }}/


cat > /etc/systemd/system/node_exporter.service<< EOF

[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
After=network.target
  
[Service]
Restart=on-failure
WorkingDirectory={{ data_path }}/node_exporter-0.18.1.linux-amd64
ExecStart={{ data_path }}/node_exporter-0.18.1.linux-amd64/node_exporter \

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter


