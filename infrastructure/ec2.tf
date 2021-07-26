resource "aws_instance" "spring_instance" {
  ami           = "ami-00f22f6155d6d92c5"
  instance_type = "t2.micro"

  # the VPC subnet
//  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  iam_instance_profile = aws_iam_instance_profile.s3-mybucket-role-instanceprofile.name

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
  user_data = <<EOF
#! /bin/bash
sudo yum update
sudo yum install java-1.8.0
BUCKET=`${module.codepipeline_bucket.bucket}`
LATEST_JAR=`aws s3 ls $BUCKET --recursive | sort | tail -n 1 | awk '{print $4}'`
aws s3 cp s3://$BUCKET/$LATEST_JAR ./latest-jar
unzip latest-jar
java -jar *.jar
EOF
}

resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = file(var.path_to_public_key)
}

resource "aws_iam_role" "s3-mybucket-role" {
  name               = "s3-mybucket-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_instance_profile" "s3-mybucket-role-instanceprofile" {
  name = "s3-mybucket-role"
  role = aws_iam_role.s3-mybucket-role.name
}

resource "aws_iam_role_policy" "s3-mybucket-role-policy" {
  name = "s3-mybucket-role-policy"
  role = aws_iam_role.s3-mybucket-role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "s3:*"
            ],
            "Resource": [
              "${module.codepipeline_bucket.arn}",
              "${module.codepipeline_bucket.arn}/*"
            ]
        }
    ]
}
EOF

}



