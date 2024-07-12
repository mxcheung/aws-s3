from aws_cdk import (
    core,
    aws_s3 as s3,
    aws_iam as iam,
    aws_secretsmanager as secretsmanager,
)

class S3WithIamAndSecretsStack(core.Stack):

    def __init__(self, scope: core.Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)

        # Create an S3 bucket
        bucket = s3.Bucket(self, "MyBucket")

        # Create an IAM user
        user = iam.User(self, "MyUser")

        # Create access keys for the user
        access_key = iam.CfnAccessKey(self, "MyAccessKey", user_name=user.user_name)

        # Store the access key and secret in Secrets Manager
        secret = secretsmanager.Secret(self, "MySecret",
            secret_string_template=core.SecretValue.plain_text(
                '{"AccessKeyId":"' + access_key.ref + '","SecretAccessKey":"' + access_key.attr_secret_access_key + '"}'
            ),
            generate_secret_string=secretsmanager.SecretStringGenerator(
                secret_string_template='{}',
                generate_string_key='password'
            )
        )

        # Allow the IAM user to access the S3 bucket
        bucket.grant_read_write(user)

        # Allow Secrets Manager to rotate the access keys
        secret.add_rotation_schedule("MySecretRotation", rotation_lambda=user)

app = core.App()
S3WithIamAndSecretsStack(app, "S3WithIamAndSecretsStack")
app.synth()
