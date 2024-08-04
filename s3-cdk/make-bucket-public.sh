#!/bin/bash

# Define the bucket name
# bucket_name="your-bucket-name"

# Iterate over each bucket
for bucket in $(aws s3api list-buckets --query "Buckets[].Name" --output text)
do
  # Get the tags for the current bucket
  tags=$(aws s3api get-bucket-tagging --bucket $bucket --query "TagSet[?Key=='Department' && Value=='Marketing']" --output json)

  # Check if the tags array is not empty
  if [ "$(echo "$tags" | jq length)" -gt 0 ]; then
    bucket_name=$bucket 
    echo "Bucket with Department=Marketing: $bucket"
  fi
done
echo $bucket_name


# Create a bucket policy JSON content
bucket_policy=$(cat <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::$bucket_name/*"
    }
  ]
}
EOF
)

# Apply the bucket policy
aws s3api put-bucket-policy --bucket "$bucket_name" --policy "$bucket_policy"

# Update public access settings
aws s3api put-public-access-block --bucket "$bucket_name" --public-access-block-configuration BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false

aws s3 cp /home/ec2-user/environment/aws-codebuild/multi-repo/s3_repo/data-folder/index.html s3://$bucket_name/

echo "Bucket $bucket_name is now public."
