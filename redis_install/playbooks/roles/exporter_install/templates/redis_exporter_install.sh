#!/bin/bash

cd {{ data_path }}/soft
tar -xf {{ exporter_name }} -C {{ data_path }}/redis_exporter
cd {{ data_path }}/redis_exporter
mv redis_exporter-v{{ version }}.linux-amd64/redis_exporter /usr/local/bin/
chmod +x /usr/local/bin/redis_exporter
cat > /etc/systemd/system/redis_exporter.service<< EOF

[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
After=network.target
  
[Service]
Restart=on-failure
WorkingDirectory={{ data_path }}/redis_exporter/redis_exporter-v{{ version }}.linux-amd64
ExecStart=/usr/local/bin/redis_exporter \

[Install]
WantedBy=multi-user.target
EOF
chown -R app:app /etc/systemd/system/redis_exporter.service
chown -R app:app /usr/local/bin/redis_exporter
systemctl daemon-reload
systemctl start redis_exporter
systemctl enable redis_exporter