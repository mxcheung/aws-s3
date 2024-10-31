#!/bin/bash

BASE_BUCKET_NAME="s3triggerlambdabucketqaisar"
UNIQUE_SUFFIX=$(date +%Y%m%d%H%M%S)  # Generate a unique suffix based on current timestamp
export S3_BUCKET_NAME="${BASE_BUCKET_NAME}${UNIQUE_SUFFIX}"  # Concatenate to create a unique bucket name

aws s3api create-bucket \
  --bucket $S3_BUCKET_NAME
