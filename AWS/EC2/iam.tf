resource "aws_iam_role" "<instance-role-name>" {
  name = "${var.environment}-${var.tags.name}-admin-role"

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

  tags = {
     Name = "${var.environment}-${var.tags.name}-instance"
     CreatedByTerraform = var.tags.CreatedByTerraform
     Environment = var.environment
     ManagedBy  = var.tags.ManagedBy
     }
}

resource "aws_iam_instance_profile" "<instance-profile>" {
  name = "${var.environment}-${var.tags.name}-instance-profile"
  role = aws_iam_role.<instance-role-name>.name
}



resource "aws_iam_role_policy" "<instance-role-name>_policy" {
  name = "${var.environment}-${var.tags.name}-policy"
  role = aws_iam_role.<instance-role-name>.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
