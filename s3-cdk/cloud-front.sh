#!/bin/bash

# Set variables
# BUCKET_NAME="your-bucket-name"
INDEX_FILE="index.html"
UNIQUE_STRING=$(date +%s)


# Define the bucket name
# bucket_name="your-bucket-name"

# Iterate over each bucket
for bucket in $(aws s3api list-buckets --query "Buckets[].Name" --output text)
do
  # Get the tags for the current bucket
  tags=$(aws s3api get-bucket-tagging --bucket $bucket --query "TagSet[?Key=='Project' && Value=='Cookies']" --output json)

  # Check if the tags array is not empty
  if [ "$(echo "$tags" | jq length)" -gt 0 ]; then
    BUCKET_NAME=$bucket 
    echo "Bucket with Project=Cookies: $bucket"
  fi
done
echo $BUCKET_NAME


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
