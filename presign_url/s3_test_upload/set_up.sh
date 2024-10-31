#!/bin/bash

export LAMBDA_FUNCTION_NAME="S3PresignURLLambda"
export LAMBDA_ROLE_NAME="LambdaS3ExecutionRole"

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' --output text)

BASE_BUCKET_NAME="s3triggerlambdabucketqaisar"
REGION="us-east-1"                                  # Replace with your AWS region

# Get the existing S3 bucket name based on the base name
export S3_BUCKET_NAME=$(aws s3api list-buckets --query "Buckets[?starts_with(Name, \`${BASE_BUCKET_NAME}\`)].Name" --output text)


AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' --output text)
REGION=$(aws configure get region)

# aws s3 cp ./test-upload.txt s3://$S3_BUCKET_NAME/


# Variables
OBJECT_KEY="test-upload.txt"                        # The object key (filename) in S3
USER_ID="12345"                                     # User ID metadata
USERNAME="exampleUser"                              # Username metadata
REGION="us-east-1"                                  # Replace with your AWS region

# Invoke the Lambda function to get the presigned URL

# Invoke the Lambda function to get the presigned URL
RESPONSE=$(aws lambda invoke \
    --function-name $LAMBDA_FUNCTION_NAME \
    --payload fileb://invoke-payload.json \
    --region $REGION \
    response.json)


# Extract the body from the response and then the presigned URL
PRESIGNED_URL=$(jq -r '.body | fromjson | .presigned_url' response.json)

# Print the presigned URL
echo "Presigned URL: $PRESIGNED_URL"

# Upload the file using curl
curl -X PUT -T ./test-upload.txt "$PRESIGNED_URL"

# Check the exit status of the curl command
if [ $? -eq 0 ]; then
    echo "File uploaded successfully!"
else
    echo "Failed to upload file."
fi

# Clean up
# rm response.json
