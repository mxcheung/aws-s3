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
