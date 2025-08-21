import boto3

s3 = boto3.client("s3")

# Local file path
local_file = "example.txt"

# Target S3 bucket and key (path inside the bucket)
bucket = "my-bucket"
key = "backup/example.txt"

# Copy (upload) the file
s3.upload_file(local_file, bucket, key)

print(f"✅ Copied {local_file} to s3://{bucket}/{key}")
