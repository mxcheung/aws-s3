import boto3
import json
from datetime import datetime, timedelta

# Initialize the S3 client
s3_client = boto3.client('s3')

# Specify your parameters
bucket_name = 'your-unique-bucket-name'
object_key = 'test-upload.txt'
user_id = '12345'
username = 'exampleUser'
expiration = 3600  # 1 hour

# Generate a presigned URL for uploading the object with metadata
presigned_url = s3_client.generate_presigned_url('put_object',
    Params={
        'Bucket': bucket_name,
        'Key': object_key,
        'Metadata': {
            'user_id': user_id,
            'username': username
        }
    },
    ExpiresIn=expiration
)

print(f'Presigned URL: {presigned_url}')
