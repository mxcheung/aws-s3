import json
import boto3
import os

s3_client = boto3.client('s3')

def lambda_handler(event, context):
    bucket_name = os.environ['BUCKET_NAME']  # Set this as an environment variable
    object_key = event['object_key']          # Get the object key from the event
    user_id = event['user_id']                # Get user ID from the event
    username = event['username']              # Get username from the event
    expiration = 3600                         # URL expiration time in seconds
    max_file_size = event['max_file_size']    # Get max_file_size from the event
    md5_hash = event['md5_hash']              # Get md5_hash from the event

    # Generate a presigned URL for uploading the object
    presigned_url = s3_client.generate_presigned_url(
        'put_object',
        Params={
            'Bucket': bucket_name,
            'Key': object_key,
            'Metadata': {
                'user_id': user_id,
                'username': username,
                'max_file_size': max_file_size,
                'md5_hash': md5_hash                
            }
        },
        ExpiresIn=expiration
    )

    return {
        'statusCode': 200,
        'body': json.dumps({'presigned_url': presigned_url})
    }
