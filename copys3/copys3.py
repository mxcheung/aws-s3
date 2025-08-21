import boto3

s3 = boto3.client("s3")

copy_source = {
    'Bucket': 'source-bucket',
    'Key': 'source-folder/myfile.txt'
}

destination_bucket = "dest-bucket"
destination_key = "dest-folder/myfile.txt"

s3.copy(copy_source, destination_bucket, destination_key)

print(f"Copied to s3://{destination_bucket}/{destination_key}")
