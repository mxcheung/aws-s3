import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';
import * as s3 from '@aws-cdk/aws-s3';
// import * as sqs from 'aws-cdk-lib/aws-sqs';

export class S3CdkStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // The code that defines your stack goes here

    // example resource
    // const queue = new sqs.Queue(this, 'S3CdkQueue', {
    //   visibilityTimeout: cdk.Duration.seconds(300)
    // });

    // Create an S3 bucket
    new s3.Bucket(this, 'MyS3Bucket');
  }
}
