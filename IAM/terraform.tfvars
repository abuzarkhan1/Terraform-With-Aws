region               = "us-east-1"
iam_user_name        = "abuzar"
iam_user_path        = "/system/"
iam_user_tags        = { tag-key = "tag-value" }
iam_user_policy_name = "test"
policy_actions       = ["ec2:Describe*"]
policy_resources     = ["*"]
