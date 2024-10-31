#!/bin/bash

export S3_BUCKET_NAME="s3triggerlambdabucketqaisar"
export LAMBDA_FUNCTION_NAME="S3PresignURLLambda"
export LAMBDA_ROLE_NAME="LambdaS3ExecutionRole"

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' --output text)

# aws s3 cp ./test-upload.txt s3://$S3_BUCKET_NAME/


# Variables
OBJECT_KEY="test-upload.txt"                        # The object key (filename) in S3
USER_ID="12345"                                     # User ID metadata
USERNAME="exampleUser"                              # Username metadata
REGION="us-east-1"                                  # Replace with your AWS region

# Invoke the Lambda function to get the presigned URL
PRESIGNED_URL=$(aws lambda invoke \
    --function-name $LAMBDA_FUNCTION_NAME \
    --payload "{\"object_key\":\"$OBJECT_KEY\", \"user_id\":\"$USER_ID\", \"username\":\"$USERNAME\"}" \
    --region $REGION \
    response.json)

# Read the presigned URL from the response
PRESIGNED_URL=$(jq -r '.presigned_url' response.json)

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
