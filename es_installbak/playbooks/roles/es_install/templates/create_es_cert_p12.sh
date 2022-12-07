#!/bin/bash

if [ -f {{ es_cert_p12 }} ]; then
  echo "no-change"
  exit 0
fi

{{ es_worker_path }}/bin/elasticsearch-certutil cert \
  --ca {{ es_ca_p12 }} \
  --ca-pass {{ es_ca_pass }} \
  --pass "" \
  --out {{ es_cert_p12 }}
