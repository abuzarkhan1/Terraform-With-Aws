provider "aws" {
  region = var.region
}

# IAM User
resource "aws_iam_user" "lb" {
  name = var.iam_user_name
  path = var.iam_user_path

  tags = var.iam_user_tags
}

# IAM Access Key
resource "aws_iam_access_key" "lb" {
  user = aws_iam_user.lb.name
}

# IAM Policy Document
data "aws_iam_policy_document" "lb_ro" {
  statement {
    effect    = "Allow"
    actions   = var.policy_actions
    resources = var.policy_resources
  }
}

# IAM User Policy
resource "aws_iam_user_policy" "lb_ro" {
  name   = var.iam_user_policy_name
  user   = aws_iam_user.lb.name
  policy = data.aws_iam_policy_document.lb_ro.json
}
