#!/bin/bash


export S3_BUCKET_NAME="s3triggerlambdabucketqaisar"

aws s3api create-bucket \
  --bucket $S3_BUCKET_NAME
