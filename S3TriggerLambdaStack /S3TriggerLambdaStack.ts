import * as cdk from 'aws-cdk-lib';
import { Stack, StackProps } from 'aws-cdk-lib';
import * as s3 from 'aws-cdk-lib/aws-s3';
import * as lambda from 'aws-cdk-lib/aws-lambda';
import * as s3n from 'aws-cdk-lib/aws-s3-notifications';
import { Construct } from 'constructs';

export class S3TriggerLambdaStack extends Stack {
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);

    // Create an S3 bucket
    const bucket = new s3.Bucket(this, 'MyBucket', {
      removalPolicy: cdk.RemovalPolicy.DESTROY,  // Automatically delete bucket on stack deletion (for dev purposes)
      autoDeleteObjects: true,                    // Delete objects in the bucket on stack deletion (for dev purposes)
    });

    // Create a Python Lambda function
    const myLambdaFunction = new lambda.Function(this, 'MyLambdaFunction', {
      runtime: lambda.Runtime.PYTHON_3_9,           // Use Python 3.9 runtime
      code: lambda.Code.fromAsset('lambda'),        // Lambda code is in the 'lambda' directory
      handler: 'lambda_handler.handler',            // File is 'lambda_handler.py', function is 'handler'
    });

    // Grant the Lambda function permissions to read from the bucket
    bucket.grantRead(myLambdaFunction);

    // Add an S3 event notification to trigger Lambda on object creation
    bucket.addEventNotification(s3.EventType.OBJECT_CREATED, new s3n.LambdaDestination(myLambdaFunction));
  }
}
