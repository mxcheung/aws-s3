#!/bin/bash


export LAMBDA_FUNCTION_NAME="S3TriggerLambda"
export LAMBDA_ROLE_NAME="LambdaS3ExecutionRole"

BASE_BUCKET_NAME="s3triggerlambdabucket"
REGION="us-east-1"                                  # Replace with your AWS region

# Get the existing S3 bucket name based on the base name
export S3_BUCKET_NAME=$(aws s3api list-buckets --query "Buckets[?starts_with(Name, \`${BASE_BUCKET_NAME}\`)].Name" --output text)

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
