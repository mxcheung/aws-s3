#!/bin/bash

export S3_BUCKET_NAME="s3triggerlambdabucketqaisar"
export LAMBDA_FUNCTION_NAME="S3TriggerLambda"
export LAMBDA_ROLE_NAME="LambdaS3ExecutionRole"

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' --output text)


aws s3 cp ./test-upload.txt s3://$S3_BUCKET_NAME/
