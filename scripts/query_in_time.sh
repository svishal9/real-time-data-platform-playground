#!/bin/bash

set -euo pipefail

echo "Selecting all rows from iceberg table default.test_table via DuckDB" >&2

echo 'Waiting for MinIO to be ready...';
while ! nc -z minio 9000 2>/dev/null; do
  sleep 1;
done;
echo 'MinIO is ready.';

echo 'Waiting for Kafka Connect to start listening on http://connect:8083 ⏳';
while ! curl -s http://connect:8083/; do
  sleep 1;
done;
echo 'Kafka Connect is ready.';

echo 'Querying DuckDB...';
./duckdb <<EOF
INSTALL httpfs;
LOAD httpfs;
CREATE SECRET secret1 (
  TYPE S3,
  KEY_ID 'minio',
  SECRET 'minio123',
  REGION 'ap-southeast-2',
  ENDPOINT 'minio:9000',
  USE_SSL false
);
SET s3_endpoint='http://minio:9000';
SET s3_access_key_id='minio';
SET s3_secret_access_key='minio123';
SET s3_region='ap-southeast-2';
SET s3_url_style='path';
SET unsafe_enable_version_guessing = true;
SELECT * FROM iceberg_scan('s3://iceberg/default/test_table');
EOF