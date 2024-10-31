#!/bin/bash


export S3_BUCKET_NAME="S3TriggerLambdaBucketQaisar"

aws s3api create-bucket \
  --bucket $S3_BUCKET_NAME
