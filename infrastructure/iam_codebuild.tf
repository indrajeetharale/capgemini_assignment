resource "aws_iam_role" "codebuild_role" {
  name = "${var.project_prefix}-codebuild-role"
  tags = var.tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

// Following IAM policy should be restricted for production case, but for example purposes I am proviging full access to codebuild.
data "aws_iam_policy_document" "codebuild_role_policy_document" {
//  statement {
//    effect = "Allow"
//    actions = [
//      "logs:CreateLogGroup",
//      "logs:CreateLogStream",
//      "logs:PutLogEvents",
//    ]
//    resources = ["*", ]
//  }

    statement {
    effect = "Allow"
    actions = [
      "*",
    ]
    resources = ["*", ]
  }

  //  statement {
  //    effect = "Allow"
  //    actions = [
  //      "sts:AssumeRole",
  //    ]
  //    resources = values(var.deployment_role_arn)
  //  }

//  statement {
//    effect = "Allow"
//    actions = [
//      "codecommit:GitPull",
//    ]
//    resources = ["*", ]
//  }
//
//  statement {
//    effect = "Allow"
//    actions = [
//      "s3:PutObject",
//      "s3:PutObjectAcl",
//      "s3:DeleteObject",
//      "s3:PutObjectTagging",
//      "s3:AbortMultipartUpload",
//      "s3:ListMultipartUploadParts",
//      "s3:ListBucket",
//      "s3:CreateBucket",
//      "s3:GetBucketLocation",
//      "s3:ListAllMyBuckets",
//      "s3:GetObject",
//      "s3:GetBucketPolicy",
//      "s3:GetBucketVersioning",
//      "s3:GetObjectVersion",
//      "s3:PutBucketPolicy"
//    ]
//    resources = ["*"]
//  }
//
//  statement {
//    effect = "Allow"
//    actions = [
//      "codebuild:BatchGetBuilds",
//      "codebuild:StartBuild",
//    ]
//    resources = ["*", ]
//  }
//
//  statement {
//    effect = "Allow"
//    actions = [
//      "ec2:CreateNetworkInterface",
//      "ec2:DescribeDhcpOptions",
//      "ec2:DescribeNetworkInterfaces",
//      "ec2:DeleteNetworkInterface",
//      "ec2:DescribeSubnets",
//      "ec2:DescribeSecurityGroups",
//      "ec2:DescribeVpcs",
//      "ec2:CreateNetworkInterfacePermission"
//    ]
//    resources = ["*", ]
//  }
//
//  statement {
//    effect    = "Allow"
//    actions   = ["ssm:Get*", ]
//    resources = ["*", ]
//  }
//
//  statement {
//    effect = "Allow"
//    actions = [
//      "dynamodb:GetItem",
//      "dynamodb:PutItem",
//      "dynamodb:DeleteItem",
//    ]
//    resources = ["*", ]
//  }
//
//  statement {
//    effect = "Allow"
//    actions = [
//      "kms:Decrypt",
//      "kms:ListKeys",
//      "kms:Encrypt",
//      "kms:ReEncrypt*",
//      "kms:ListAliases",
//      "kms:GenerateDataKey",
//      "kms:DescribeKey"
//    ]
//    resources = ["*"]
//  }
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name   = "${var.project_prefix}-codebuild-policy"
  role   = aws_iam_role.codebuild_role.id
  policy = data.aws_iam_policy_document.codebuild_role_policy_document.json
}