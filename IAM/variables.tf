variable "region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "iam_user_name" {
  description = "Name of the IAM user"
  default     = "abuzar"
}

variable "iam_user_path" {
  description = "Path for the IAM user"
  default     = "/system/"
}

variable "iam_user_tags" {
  description = "Tags for the IAM user"
  type        = map(string)
  default = {
    tag-key = "tag-value"
  }
}

variable "iam_user_policy_name" {
  description = "Name of the IAM user policy"
  default     = "test"
}

variable "policy_actions" {
  description = "List of allowed actions for the policy"
  type        = list(string)
  default     = ["ec2:Describe*"]
}

variable "policy_resources" {
  description = "List of resources allowed by the policy"
  type        = list(string)
  default     = ["*"]
}
