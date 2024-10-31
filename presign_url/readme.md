

https://theburningmonk.com/2020/04/hit-the-6mb-lambda-payload-limit-heres-what-you-can-do/

Option 2: use presigned S3 URL


```
aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text > MyKeyPair.pem
```

```
ssh-keygen -y -f your-key.pem > your-key.pub
aws ec2 import-key-pair --key-name "MyKeyPair" --public-key-material file://your-key.pub
```
