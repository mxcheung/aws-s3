import json

def lambda_handler(event, context):
    print("Event received:", json.dumps(event))
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        print(f"File uploaded: {bucket}/{key}")
    return {
        'statusCode': 200,
        'body': json.dumps('Success')
    }
