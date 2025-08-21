import boto3

s3 = boto3.client("s3")

bucket = "my-bucket"
key = "backup/example.txt"
local_file = "example.txt"   # destination on your local machine

s3.download_file(bucket, key, local_file)

print(f"✅ Downloaded s3://{bucket}/{key} → {local_file}")
