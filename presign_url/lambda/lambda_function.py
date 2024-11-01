import json
import boto3
import base64
import hashlib
from botocore.exceptions import ClientError

def lambda_handler(event, context):
    # Initialize the S3 client
    s3_client = boto3.client('s3')

    # Loop through each record in the event
    for record in event['Records']:
        # Get the bucket name and object key from the event
        bucket_name = record['s3']['bucket']['name']
        object_key = record['s3']['object']['key']

        try:
            # Get the object from S3
            response = s3_client.get_object(Bucket=bucket_name, Key=object_key)

            # Read the contents of the file
            file_contents = response['Body'].read().decode('utf-8')

            # Retrieve user metadata
            user_id = response['Metadata'].get('user_id')
            username = response['Metadata'].get('username')
            max_file_size = response['Metadata'].get('max_file_size')
            md5_hash = response['Metadata'].get('md5_hash')

            # Print the file contents and user credentials to CloudWatch Logs
            print(f'Contents of the file {object_key} in bucket {bucket_name}:')
            print(file_contents)
            print(f'User ID: {user_id}')
            print(f'Username: {username}')
            print(f'Max File Size: {max_file_size}')
            print(f'MD5 Hash: {md5_hash}')

            # Calculate MD5 hash of the UTF-8 string
            calculated_md5 = base64.b64encode(hashlib.md5(file_contents.encode('utf-8')).digest()).decode('utf-8')
            print(f'Calculated MD5 Hash: {calculated_md5}')

        
        except Exception as e:
            print(f'Error retrieving object {object_key} from bucket {bucket_name}. Error: {str(e)}')

    return {
        'statusCode': 200,
        'body': json.dumps('Lambda function executed successfully!')
    }
