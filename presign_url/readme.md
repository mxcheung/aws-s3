# metrics using ec2
## ec

```
t3.small or t3.medium
30 gb
```
```
ssh -i "MyKeyPair.pem" ec2-user@ec2-54-234-111-22.compute-1.amazonaws.com
sudo yum -y install git
git clone https://github.com/mxcheung/aws-cloudwatch.git
cd /home/ec2-user/aws-cloudwatch/expiration_ttl
. ./set_up.sh
```


## quick start

https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#LaunchInstances:

Instance Type:
   - t3.medium

Key pair (login) 
   - MyKeyPair.pem

Network settings
  - Allow SSH traffic from
  - Allow HTTPS traffic from the internet
  - Allow HTTP traffic from the internet

Configure storage
  - 30gb





https://theburningmonk.com/2020/04/hit-the-6mb-lambda-payload-limit-heres-what-you-can-do/

Option 2: use presigned S3 URL


```
aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text > MyKeyPair.pem
```

```
ssh-keygen -y -f your-key.pem > your-key.pub
aws ec2 import-key-pair --key-name "MyKeyPair" --public-key-material file://your-key.pub
```


## result using presigned url
```
Presigned URL: https://s3triggerlambdabucketqaisar20241031054326.s3.amazonaws.com/test-upload.txt?AWSAccessKeyId=ASIAVRXXXXVKCT&Signature=cldM43ZtLwa53qDAmXi06r7Q2UI%3D&x-amz-meta-user_id=12345&x-amz-meta-username=exampleUser&x-amz-security-token=IQoJb3JpZ2luX2VjEA4aCXVzLWVhc3QtMSJIMEYCIQCQHUSTAApPz%2FeZDPHVRc0LUqWUj5wrNWmCgRjwXoElXUC50j0IDvRxWoi2Q5UFiURCyxwm1jwz%2Ftbnz2YyLqhCyvWn3u5KXkD0Hs4P6rt1ktKBT0VCGvGmyWTa%2BLphdmyRKjQ4WZtscIhJjiQbul4SY%3D&Expires=1730357826
File uploaded successfully!
[ec2-user@ip-172-31-41-118 s3_test_upload]$ exi
```

```
2024-11-01T06:05:46.320Z User ID: 12345
2024-11-01T06:05:46.320Z Username: exampleUser
2024-11-01T06:05:46.320Z Max File Size: 10485760
2024-11-01T06:05:46.320Z Original MD5 Hash: /y7uw//R72/ErOEPC1Fo8Q==
Original MD5 Hash: /y7uw//R72/ErOEPC1Fo8Q==
2024-11-01T06:05:46.320Z Calculated MD5 Hash: /y7uw//R72/ErOEPC1Fo8Q==
2024-11-01T06:05:46.320Z
Original MD5 Hash: /y7uw//R72/ErOEPC1Fo8Q==
2024-11-01T06:05:46.320Z
Calculated MD5 Hash: /y7uw//R72/ErOEPC1Fo8Q==
2024-11-01T06:05:46.320Z MD5 hash match for test-upload.txt in s3triggerlambdabucketqaisar20241101060518
2024-11-01T06:05:46.322Z END RequestId: 4136466b-adcf-498f-a964-d1d8f30ff422
2024-11-01T06:05:46.323Z REPORT RequestId: 4136466b-adcf-498f-a964-d1d8f30ff422 Duration: 2827.05 ms Billed Duration: 2828 ms Memory Size: 128 MB Max Memory Used: 81 MB Init Duration: 297.42 ms
```
