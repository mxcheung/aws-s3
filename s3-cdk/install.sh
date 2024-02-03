#!/bin/bash
# Creates s3 bucket via cdk

echo "Welcome aws s3"

cd /home/ec2-user/environment/aws-s3/s3-cdk

cdk init app --language typescript

npm install @aws-cdk/aws-s3 @aws-cdk/aws-dynamodb @aws-cdk/aws-lambda @aws-cdk/aws-apigateway @aws-cdk/core aws-sdk @aws-cdk/aws-iam


cdk bootstrap

cdk synth

cdk deploy
