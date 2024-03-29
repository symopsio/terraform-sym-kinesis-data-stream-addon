# Deprecation Warning
The `symopsio/kinesis-data-stream-addon/sym` module is deprecated as of September 30, 2022. Please migrate to [`symopsio/kinesis-data-stream-addon/aws`](https://registry.terraform.io/modules/symopsio/secretsmgr-addon/aws/latest). This should be done automatically if you are have migrated to the `symopsio/runtime-connector/aws` module.

# kinesis-data-stream-addon

The `kinesis-data-stream-addon` module adds AWS Kinesis Data Stream access to a Sym runtime connector module.

This `Addon` will add a policy to the role generated by a `Connector`.

You typically include this `Addon` by adding `aws/kinesis-data-stream` to the  `addons` property of the runtime connector module, rather than referring to the policy ARN itself.

Kinesis Data Stream ARNs must be provided, as IAM policies for Data Streams cannot use wildcards with tags or resource names.

```hcl
module "runtime_connector" {
  source  = "symopsio/runtime-connector/sym"
  version = ">= 1.0.0"

  addons      = ["aws/kinesis-data-stream"]
  environment = "sandbox"

  addon_params = {
    "aws/kinesis-data-stream" = {
       "stream_arns" = ["arn:aws:kinesis:*:111122223333:stream/my-stream"]
    }
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | An environment qualifier for the resources this module creates, to support a Terraform SDLC. The environment value is also the tag value that secrets must be tagged with to be accessible by this addon. | `string` | n/a | yes |
| <a name="input_stream_arns"></a> [stream\_arns](#input\_stream\_arns) | List of Data Stream ARNs allowed to be accessed by the Sym Runtime. | `list(string)` | `[]` | no |
| <a name="input_tag_name"></a> [tag\_name](#input\_tag\_name) | Name of the tag that resources must be tagged with to be accessible by this addon. | `string` | `"SymEnv"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_arn"></a> [policy\_arn](#output\_policy\_arn) | Kinesis Firehose's access policy arn |
<!-- END_TF_DOCS -->
