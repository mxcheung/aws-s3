#!/bin/bash

cd /home/ec2-user/aws-cloudwatch/expiration_poll/user_credentials
. ./set_up.sh

cd /home/ec2-user/aws-cloudwatch/expiration_poll/iam
. ./set_up.sh

cd /home/ec2-user/aws-cloudwatch/expiration_poll/s3
. ./set_up.sh

cd /home/ec2-user/aws-cloudwatch/expiration_poll/lambda
. ./set_up.sh


