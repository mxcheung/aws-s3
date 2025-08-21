import boto3

s3 = boto3.client("s3")

local_file = "example.txt"
bucket = "my-bucket"
key = "backup/example.txt"

# Optional: specify a custom KMS key ID or alias
kms_key_id = "arn:aws:kms:ap-southeast-2:123456789012:key/abcd-1234-efgh-5678"

s3.upload_file(
    local_file,
    bucket,
    key,
    ExtraArgs={
        "ServerSideEncryption": "aws:kms",
        "SSEKMSKeyId": kms_key_id
    }
)

print(f"✅ Copied {local_file} to s3://{bucket}/{key} with KMS encryption")
