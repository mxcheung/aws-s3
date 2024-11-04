import * as cdk from 'aws-cdk-lib';
import { Stack, StackProps } from 'aws-cdk-lib';
import * as s3 from 'aws-cdk-lib/aws-s3';
import * as s3n from 'aws-cdk-lib/aws-s3-notifications';
import * as lambda from 'aws-cdk-lib/aws-lambda';
import { Construct } from 'constructs';

export interface AddS3EventNotificationStackProps extends StackProps {
  bucketName: string;
  lambdaFunctionName: string;
}

export class AddS3EventNotificationStack extends Stack {
  constructor(scope: Construct, id: string, props: AddS3EventNotificationStackProps) {
    super(scope, id, props);

    const { bucketName, lambdaFunctionName } = props;

    // Reference the existing S3 bucket by its name
    const bucket = s3.Bucket.fromBucketName(this, 'ExistingBucket', bucketName);

    // Reference the existing Lambda function by its name
    const myLambdaFunction = lambda.Function.fromFunctionName(this, 'ExistingLambdaFunction', lambdaFunctionName);

    // Add the S3 event notification to trigger the Lambda function on object creation
    bucket.addEventNotification(s3.EventType.OBJECT_CREATED, new s3n.LambdaDestination(myLambdaFunction));
  }
}
