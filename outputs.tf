output "policy_arn" {
  description = "Kinesis Firehose's access policy arn"
  value       = aws_iam_policy.this.arn
}
