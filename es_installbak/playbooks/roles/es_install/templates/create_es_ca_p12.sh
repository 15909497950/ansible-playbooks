#!/bin/bash

if [ -f {{ es_ca_p12 }} ]; then
  echo "no-change"
  exit 0
fi
{{ es_worker_path }}/bin/elasticsearch-certutil ca \
  --pass {{ es_ca_pass }} \
  --out {{ es_ca_p12 }} \
  --silent
