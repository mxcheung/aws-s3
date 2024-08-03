import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';
import * as s3 from 'aws-cdk-lib/aws-s3';
import * as dynamodb from 'aws-cdk-lib/aws-dynamodb'
import { RemovalPolicy, Stack, StackProps, Duration } from 'aws-cdk-lib';
import * as s3deploy from 'aws-cdk-lib/aws-s3-deployment';
import * as iam from 'aws-cdk-lib/aws-iam';
// import * as sqs from 'aws-cdk-lib/aws-sqs';

export class S3CdkStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);
    

    // The code that defines your stack goes here

    // create lifecycle rule
      const lifecycle_rule_intelligent =   
       {
          transitions: [
            {
              storageClass: s3.StorageClass.INTELLIGENT_TIERING,
              transitionAfter: cdk.Duration.days(30), // Adjust the transitionAfter value as needed
            },
          ],
        }
    // Create an S3 bucket with Intelligent-Tiering storage class
      const s3Bucket = new s3.Bucket(this, 'MyS3Bucket', {
      removalPolicy: cdk.RemovalPolicy.DESTROY, // This is just an example, adjust according to your needs
      autoDeleteObjects: true, // This is just an example, adjust according to your needs
      versioned: true, // Enable versioning for the bucket (optional)
      websiteIndexDocument: 'index.html',
      lifecycleRules: [ lifecycle_rule_intelligent ],
    });

    
    // Deploy files to the bucket
    new s3deploy.BucketDeployment(this, 'DeployFiles', {
      sources: [s3deploy.Source.asset('./data-folder')],
      destinationBucket: s3Bucket,
    });
    
  }
}
