#!/bin/bash

cd {{ data_path }}/soft
tar -xf {{ exporter_name }} -C {{ data_path }}/kafka_exporter
cd {{ data_path }}/kafka_exporter
mv kafka_exporter-{{ version }}.linux-amd64/kafka_exporter /usr/local/bin/
chmod +x /usr/local/bin/kafka_exporter
