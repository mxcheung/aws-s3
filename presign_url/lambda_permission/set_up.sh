#!/bin/bash


export LAMBDA_FUNCTION_NAME="S3TriggerLambda"
export LAMBDA_ROLE_NAME="LambdaS3ExecutionRole"

BASE_BUCKET_NAME="s3triggerlambdabucketqaisar"
REGION="us-east-1"                                  # Replace with your AWS region

# Get the existing S3 bucket name based on the base name
export S3_BUCKET_NAME=$(aws s3api list-buckets --query "Buckets[?starts_with(Name, \`${BASE_BUCKET_NAME}\`)].Name" --output text)

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' --output text)

aws lambda add-permission \
  --function-name $LAMBDA_FUNCTION_NAME \
  --principal s3.amazonaws.com \
  --statement-id s3invoke \
  --action "lambda:InvokeFunction" \
  --source-arn arn:aws:s3:::$S3_BUCKET_NAME \
  --source-account $AWS_ACCOUNT_ID



