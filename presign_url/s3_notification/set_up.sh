#!/bin/bash

export S3_BUCKET_NAME="S3TriggerLambdaBucketQaisar"
export LAMBDA_FUNCTION_NAME="S3TriggerLambda"
export LAMBDA_ROLE_NAME="LambdaS3ExecutionRole"

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' --output text)
REGION=$(aws configure get region)


aws s3api put-bucket-notification-configuration \
  --bucket $S3_BUCKET_NAME \
  --notification-configuration "$(jq -n --arg lambda_arn "arn:aws:lambda:$REGION:$AWS_ACCOUNT_ID:function:S3TriggerLambda" '{
    "LambdaFunctionConfigurations": [
      {
        "LambdaFunctionArn": $lambda_arn,
        "Events": ["s3:ObjectCreated:*"]
      }
    ]
  }')"
