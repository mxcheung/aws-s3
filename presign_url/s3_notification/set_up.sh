#!/bin/bash

export S3_BUCKET_NAME="S3TriggerLambdaBucketQaisar"
export LAMBDA_FUNCTION_NAME="S3TriggerLambda"
export LAMBDA_ROLE_NAME="LambdaS3ExecutionRole"

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' --output text)


aws s3api put-bucket-notification-configuration \
  --bucket $S3_BUCKET_NAME \
  --notification-configuration file://notification.json
