#!/bin/bash

cd {{ data_path }}/soft
tar -xf {{ exporter_name }} -C {{ data_path }}
cd {{ data_path }}
mv mongodb_exporter-{{ version }}.linux-amd64/mongodb_exporter /usr/local/bin/
chmod +x /usr/local/bin/mongodb_exporter
cat > /etc/systemd/system/mongodb_exporter.service<< EOF

[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
After=network.target
  
[Service]
Restart=on-failure
WorkingDirectory={{ data_path }}/mongodb_exporter-{{ version }}.linux-amd64
ExecStart=/usr/local/bin/mongodb_exporter --mongodb.uri=mongodb://root:"{{ mongodb_passwd }}"@{{ hostvars['']['ansible_host'] }}:27017 \

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl start mongodb_exporter
systemctl enable mongodb_exporter