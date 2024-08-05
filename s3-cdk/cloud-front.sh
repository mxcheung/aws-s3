#!/bin/bash

# Set variables
BUCKET_NAME="your-bucket-name"
INDEX_FILE="index.html"
UNIQUE_STRING=$(date +%s)

# Create S3 bucket
aws s3 mb s3://$BUCKET_NAME

# Upload index.html to S3 bucket
aws s3 cp $INDEX_FILE s3://$BUCKET_NAME/

# Make index.html publicly accessible
aws s3api put-object-acl --bucket $BUCKET_NAME --key $INDEX_FILE --acl public-read

# Enable static website hosting on S3 bucket
aws s3 website s3://$BUCKET_NAME/ --index-document $INDEX_FILE

# Set bucket policy to allow public read access
aws s3api put-bucket-policy --bucket $BUCKET_NAME --policy '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::'$BUCKET_NAME'/*"
        }
    ]
}'

# Create CloudFront distribution configuration
cat > cloudfront-config.json <<EOL
{
    "CallerReference": "$UNIQUE_STRING",
    "Aliases": {
        "Quantity": 0
    },
    "DefaultRootObject": "$INDEX_FILE",
    "Origins": {
        "Quantity": 1,
        "Items": [
            {
                "Id": "S3-$BUCKET_NAME",
                "DomainName": "$BUCKET_NAME.s3.amazonaws.com",
                "OriginPath": "",
                "CustomHeaders": {
                    "Quantity": 0
                },
                "S3OriginConfig": {
                    "OriginAccessIdentity": ""
                }
            }
        ]
    },
    "DefaultCacheBehavior": {
        "TargetOriginId": "S3-$BUCKET_NAME",
        "ViewerProtocolPolicy": "redirect-to-https",
        "AllowedMethods": {
            "Quantity": 2,
            "Items": [
                "GET",
                "HEAD"
            ],
            "CachedMethods": {
                "Quantity": 2,
                "Items": [
                    "GET",
                    "HEAD"
                ]
            }
        },
        "ForwardedValues": {
            "QueryString": false,
            "Cookies": {
                "Forward": "none"
            },
            "Headers": {
                "Quantity": 0
            },
            "QueryStringCacheKeys": {
                "Quantity": 0
            }
        },
        "MinTTL": 0,
        "DefaultTTL": 86400,
        "MaxTTL": 31536000
    },
    "Comment": "CloudFront Distribution for S3 website",
    "Enabled": true
}
EOL

# Create CloudFront distribution and capture the domain name
DISTRIBUTION_JSON=$(aws cloudfront create-distribution --distribution-config file://cloudfront-config.json)
CLOUDFRONT_URL=$(echo $DISTRIBUTION_JSON | jq -r '.Distribution.DomainName')

# Cleanup
rm cloudfront-config.json

# Output the CloudFront URL
echo "Setup complete. Your static website is accessible through the CloudFront distribution:"
echo "https://$CLOUDFRONT_URL"
