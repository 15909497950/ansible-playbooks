#!/bin/bash

cd {{ data_path }}/soft
tar -xf {{ exporter_name }} -C {{ data_path }}/rabbitmq_exporter
cd {{ data_path }}/rabbitmq_exporter
mv rabbitmq_exporter-{{ version }}.linux-amd64/rabbitmq_exporter /usr/local/bin/
chmod +x /usr/local/bin/rabbitmq_exporter
cat > /etc/systemd/system/rabbitmq_exporter.service<< EOF

[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
After=network.target
  
[Service]
Restart=on-failure
WorkingDirectory={{ data_path }}/rabbitmq_exporter/rabbitmq_exporter-{{ version }}.linux-amd64
ExecStart=/usr/local/bin/rabbitmq_exporter \

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl start rabbitmq_exporter
systemctl enable rabbitmq_exporter