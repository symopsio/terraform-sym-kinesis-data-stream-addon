data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  escaped_resource_arns = [for arn in var.stream_arns : "\"${arn}\""]
  data_stream_resource_arns = join(",", local.escaped_resource_arns)
}

resource "aws_iam_policy" "this" {
  name = "SymKinesisDataStream${title(var.environment)}"
  path = "/sym/"

  description = "Addon policy granting access to Kinesis Data Stream"
  policy      = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "kinesis:PutRecord",
        "kinesis:PutRecords"
      ],
      "Resource": [ ${local.data_stream_resource_arns} ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "kinesis:ListStreams"
      ],
      "Resource": "*"
    }
  ]
}
EOT
}
