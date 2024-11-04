
# Explanation of Each Part

# S3 Bucket: 
         The bucket object creates an S3 bucket with a deletion policy for easy cleanup (helpful during development).

# Lambda Function: 
         The myLambdaFunction object creates a Lambda function that runs on Node.js 18 and points to the code in the lambda directory. Make sure you have an index.js file there with a function named handler.

# Grant Bucket Read Permissions: 
         bucket.grantRead(myLambdaFunction) allows the Lambda to read from this bucket.
# Add S3 Event Notification: 
          The bucket.addEventNotification() method sets the Lambda to trigger whenever a new object is created in the bucket.
