#!/bin/bash


export LAMBDA_FUNCTION_NAME="S3TriggerLambda"
export LAMBDA_ROLE_NAME="LambdaS3ExecutionRole"

BASE_BUCKET_NAME="s3triggerlambdabucketqaisar"
REGION="us-east-1"                                  # Replace with your AWS region

# Get the existing S3 bucket name based on the base name
export S3_BUCKET_NAME=$(aws s3api list-buckets --query "Buckets[?starts_with(Name, \`${BASE_BUCKET_NAME}\`)].Name" --output text)

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' --output text)
REGION=$(aws configure get region)

# Generate the Lambda function ARN
LAMBDA_FUNCTION_ARN="arn:aws:lambda:$REGION:$AWS_ACCOUNT_ID:function:$LAMBDA_FUNCTION_NAME"

# Create the notification configuration JSON file
cat <<EOF > notification-config.json
{
  "LambdaFunctionConfigurations": [
    {
      "Id": "ExampleLambdaConfig",
      "LambdaFunctionArn": "$LAMBDA_FUNCTION_ARN",
      "Events": ["s3:ObjectCreated:Put"],
      "Filter": {
        "Key": {
          "FilterRules": [
            {
              "Name": "suffix",
              "Value": ".txt"
            }
          ]
        }
      }
    }
  ]
}
EOF


aws s3api put-bucket-notification-configuration \
  --bucket $S3_BUCKET_NAME \
  --notification-configuration file://notification-config.json
