import boto3

s3 = boto3.client("s3")

bucket = "my-bucket"

resp = s3.list_objects_v2(Bucket=bucket, Prefix="backup/")
for obj in resp.get("Contents", []):
    print(obj["Key"])
