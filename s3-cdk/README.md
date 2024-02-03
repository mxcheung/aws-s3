# Welcome to your CDK TypeScript project

This is a blank project for CDK development with TypeScript.

The `cdk.json` file tells the CDK Toolkit how to execute your app.

## Useful commands

* `npm run build`   compile typescript to js
* `npm run watch`   watch for changes and compile
* `npm run test`    perform the jest unit tests
* `cdk deploy`      deploy this stack to your default AWS account/region
* `cdk diff`        compare deployed stack with current state
* `cdk synth`       emits the synthesized CloudFormation template


# s3

S3


# step 1 - quickstart

```
git clone https://github.com/mxcheung/aws-s3.git
https://github.com/mxcheung/aws-s3.git
cd /home/ec2-user/environment/aws-s3/s3-cdk
. ./install.sh

```



```
mkdir s3-cdk

cd s3-cdk

cdk init app --language typescript

npm install @aws-cdk/aws-s3 @aws-cdk/aws-dynamodb @aws-cdk/aws-lambda @aws-cdk/aws-apigateway @aws-cdk/core aws-sdk @aws-cdk/aws-iam
```

# step 2 - replace cdk code

replace cdk  code /lib/dynamodb-cdk-stack.ts

copy items.json

# step 3 - cdk bootstrap and more

```
cdk bootstrap

cdk synth

cdk deploy
```



# step 5 - view cookies page via github pages
View the fortune cookies app here
Static html calls 
   * api gateway
   * aws lambda
   * aws dynamodb
   * 
https://mxcheung.github.io/


Source code for Static html is here
https://github.com/mxcheung/mxcheung.github.io
