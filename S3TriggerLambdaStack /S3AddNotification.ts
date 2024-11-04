import * as cdk from 'aws-cdk-lib';
import { Stack, StackProps } from 'aws-cdk-lib';
import * as s3 from 'aws-cdk-lib/aws-s3';
import * as s3n from 'aws-cdk-lib/aws-s3-notifications';
import * as lambda from 'aws-cdk-lib/aws-lambda';
import { Construct } from 'constructs';

export class AddS3EventNotificationStack extends Stack {
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);

    // Reference the existing S3 bucket by its name or ARN
    const bucket = s3.Bucket.fromBucketName(this, 'ExistingBucket', 'your-bucket-name');

    // Reference the existing Lambda function by its ARN or name
    const myLambdaFunction = lambda.Function.fromFunctionArn(
      this,
      'ExistingLambdaFunction',
      'arn:aws:lambda:your-region:your-account-id:function:your-lambda-function-name'
    );

    // Add the S3 event notification to trigger the Lambda function on object creation
    bucket.addEventNotification(s3.EventType.OBJECT_CREATED, new s3n.LambdaDestination(myLambdaFunction));
  }
}
