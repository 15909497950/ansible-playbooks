#!/bin/bash

cd {{ data_path }}/soft
tar -xf {{ exporter_name }} -C {{ data_path }}
cd {{ data_path }}
mv mysqld_exporter-{{ version }}.linux-amd64/mysqld_exporter /usr/local/bin/
chmod +x /usr/local/bin/mysqld_exporter
{{ data_path }}/bin/mysql -uroot -p"{{ passwd }}" -e "CREATE USER 'mysqld_exporter'@'%' IDENTIFIED BY '{{ exporter_passwd }}';"

{{ data_path }}/bin/mysql -uroot -p"{{ passwd }}" -e "GRANT ALL ON *.* TO 'mysqld_exporter'@'%';"

{{ data_path }}/bin/mysql -uroot -p"{{ passwd }}" -e "FLUSH PRIVILEGES;"

cat > /etc/.mysqld_exporter.cnf <<EOF
[client]
user=mysqld_exporter
password={{ exporter_passwd }}
EOF
cat > /etc/systemd/system/mysql_exporter.service << EOF
[Unit]
Description=Prometheus MySQL Exporter
After=network.target
User=prometheus
Group=prometheus
[Service]
Type=simple
Restart=always
ExecStart=/usr/local/bin/mysqld_exporter \
--config.my-cnf /etc/.mysqld_exporter.cnf \
--collect.global_status \
--collect.info_schema.innodb_metrics \
--collect.auto_increment.columns \
--collect.info_schema.processlist \
--collect.binlog_size \
--collect.info_schema.tablestats \
--collect.global_variables \
--collect.info_schema.query_response_time \
--collect.info_schema.userstats \
--collect.info_schema.tables \
--collect.perf_schema.tablelocks \
--collect.perf_schema.file_events \
--collect.perf_schema.eventswaits \
--collect.perf_schema.indexiowaits \
--collect.perf_schema.tableiowaits \
--collect.slave_status \
--web.listen-address=0.0.0.0:9104
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now mysql_exporter