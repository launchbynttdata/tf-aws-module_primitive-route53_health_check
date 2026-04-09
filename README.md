# tf-aws-module_primitive-route53_health_check

Terraform primitive module for a single [`aws_route53_health_check`](https://registry.terraform.io/providers/hashicorp/aws/5.100.0/docs/resources/route53_health_check).

## Overview

This module wraps one Route 53 health check resource and exposes all configurable arguments available in AWS provider `~> 5.100`, including endpoint checks, `CALCULATED`, `CLOUDWATCH_METRIC`, and `RECOVERY_CONTROL` modes.

## Usage

```hcl
module "route53_health_check" {
  source = "../.."

  type                            = var.type
  fqdn                            = var.fqdn
  ip_address                      = var.ip_address
  port                            = var.port
  request_interval                = var.request_interval
  failure_threshold               = var.failure_threshold
  resource_path                   = var.resource_path
  search_string                   = var.search_string
  measure_latency                 = var.measure_latency
  invert_healthcheck              = var.invert_healthcheck
  disabled                        = var.disabled
  enable_sni                      = var.enable_sni
  child_healthchecks              = var.child_healthchecks
  child_health_threshold          = var.child_health_threshold
  cloudwatch_alarm_name           = var.cloudwatch_alarm_name
  cloudwatch_alarm_region         = var.cloudwatch_alarm_region
  insufficient_data_health_status = var.insufficient_data_health_status
  regions                         = var.regions
  reference_name                  = var.reference_name
  routing_control_arn             = var.routing_control_arn
  tags                            = var.tags
  triggers                        = var.triggers
}
```

## Provider configuration

Configure the AWS provider in the root module. This module only defines provider requirements.


## License

See [LICENSE](LICENSE).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.10 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0, < 7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.39.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_health_check.health_check](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_child_health_threshold"></a> [child\_health\_threshold](#input\_child\_health\_threshold) | Minimum number of healthy child checks required for CALCULATED checks. | `number` | `null` | no |
| <a name="input_child_healthchecks"></a> [child\_healthchecks](#input\_child\_healthchecks) | Child health check IDs for CALCULATED checks. | `set(string)` | `null` | no |
| <a name="input_cloudwatch_alarm_name"></a> [cloudwatch\_alarm\_name](#input\_cloudwatch\_alarm\_name) | CloudWatch alarm name for CLOUDWATCH\_METRIC checks. | `string` | `null` | no |
| <a name="input_cloudwatch_alarm_region"></a> [cloudwatch\_alarm\_region](#input\_cloudwatch\_alarm\_region) | AWS region of the CloudWatch alarm for CLOUDWATCH\_METRIC checks. | `string` | `null` | no |
| <a name="input_disabled"></a> [disabled](#input\_disabled) | Whether Route 53 should stop performing checks and report healthy. | `bool` | `null` | no |
| <a name="input_enable_sni"></a> [enable\_sni](#input\_enable\_sni) | Whether HTTPS checks should include SNI in TLS client hello. | `bool` | `null` | no |
| <a name="input_failure_threshold"></a> [failure\_threshold](#input\_failure\_threshold) | Consecutive health check failures required before status changes. | `number` | `null` | no |
| <a name="input_fqdn"></a> [fqdn](#input\_fqdn) | Fully-qualified domain name of the endpoint to check. | `string` | `null` | no |
| <a name="input_insufficient_data_health_status"></a> [insufficient\_data\_health\_status](#input\_insufficient\_data\_health\_status) | Health status when CloudWatch alarm data is insufficient: Healthy, Unhealthy, or LastKnownStatus. | `string` | `null` | no |
| <a name="input_invert_healthcheck"></a> [invert\_healthcheck](#input\_invert\_healthcheck) | Whether Route 53 should invert the evaluated health status. | `bool` | `null` | no |
| <a name="input_ip_address"></a> [ip\_address](#input\_ip\_address) | IPv4 or IPv6 address of the endpoint to check. | `string` | `null` | no |
| <a name="input_measure_latency"></a> [measure\_latency](#input\_measure\_latency) | Whether Route 53 should measure/check latency for this endpoint. | `bool` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | Port on the endpoint to check. | `number` | `null` | no |
| <a name="input_reference_name"></a> [reference\_name](#input\_reference\_name) | Optional caller reference name used by Route 53 for this health check. | `string` | `null` | no |
| <a name="input_regions"></a> [regions](#input\_regions) | Optional set of AWS regions from which Route 53 performs endpoint checks. When set, Route 53 requires at least three regions. | `set(string)` | `null` | no |
| <a name="input_request_interval"></a> [request\_interval](#input\_request\_interval) | Seconds between health checks. Valid values: 10 or 30. | `number` | `null` | no |
| <a name="input_resource_path"></a> [resource\_path](#input\_resource\_path) | Path Route 53 requests for HTTP/HTTPS checks (for example, /healthz). | `string` | `null` | no |
| <a name="input_routing_control_arn"></a> [routing\_control\_arn](#input\_routing\_control\_arn) | Route 53 Application Recovery Controller routing control ARN for RECOVERY\_CONTROL checks. | `string` | `null` | no |
| <a name="input_search_string"></a> [search\_string](#input\_search\_string) | String to match in the first 5120 bytes of response body for *\_STR\_MATCH types. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to the health check. | `map(string)` | `{}` | no |
| <a name="input_triggers"></a> [triggers](#input\_triggers) | Arbitrary map of values that, when changed, force replacement. | `map(string)` | `null` | no |
| <a name="input_type"></a> [type](#input\_type) | Health check protocol/type. Valid values: HTTP, HTTPS, HTTP\_STR\_MATCH, HTTPS\_STR\_MATCH, TCP, CALCULATED, CLOUDWATCH\_METRIC, RECOVERY\_CONTROL. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the Route 53 health check. |
| <a name="output_child_health_threshold"></a> [child\_health\_threshold](#output\_child\_health\_threshold) | Child health threshold configured for CALCULATED checks. |
| <a name="output_child_healthchecks"></a> [child\_healthchecks](#output\_child\_healthchecks) | Child health check IDs configured for CALCULATED checks. |
| <a name="output_cloudwatch_alarm_name"></a> [cloudwatch\_alarm\_name](#output\_cloudwatch\_alarm\_name) | CloudWatch alarm name configured for CLOUDWATCH\_METRIC checks. |
| <a name="output_cloudwatch_alarm_region"></a> [cloudwatch\_alarm\_region](#output\_cloudwatch\_alarm\_region) | CloudWatch alarm region configured for CLOUDWATCH\_METRIC checks. |
| <a name="output_disabled"></a> [disabled](#output\_disabled) | Whether the health check is disabled. |
| <a name="output_enable_sni"></a> [enable\_sni](#output\_enable\_sni) | Whether SNI is enabled for HTTPS checks. |
| <a name="output_failure_threshold"></a> [failure\_threshold](#output\_failure\_threshold) | The failure threshold used by the health check. |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The configured endpoint FQDN, when applicable. |
| <a name="output_id"></a> [id](#output\_id) | The Route 53 health check ID. |
| <a name="output_insufficient_data_health_status"></a> [insufficient\_data\_health\_status](#output\_insufficient\_data\_health\_status) | Health status used when CloudWatch alarm data is insufficient. |
| <a name="output_invert_healthcheck"></a> [invert\_healthcheck](#output\_invert\_healthcheck) | Whether health check status inversion is enabled. |
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | The configured endpoint IP address, when applicable. |
| <a name="output_measure_latency"></a> [measure\_latency](#output\_measure\_latency) | Whether latency measurements are enabled. |
| <a name="output_port"></a> [port](#output\_port) | The configured endpoint port, when applicable. |
| <a name="output_reference_name"></a> [reference\_name](#output\_reference\_name) | Route 53 caller reference name for the health check. |
| <a name="output_regions"></a> [regions](#output\_regions) | Regions configured for endpoint checks. |
| <a name="output_request_interval"></a> [request\_interval](#output\_request\_interval) | The request interval in seconds. |
| <a name="output_resource_path"></a> [resource\_path](#output\_resource\_path) | The configured resource path for HTTP/HTTPS checks, when applicable. |
| <a name="output_routing_control_arn"></a> [routing\_control\_arn](#output\_routing\_control\_arn) | Routing control ARN configured for RECOVERY\_CONTROL checks. |
| <a name="output_search_string"></a> [search\_string](#output\_search\_string) | The configured search string for *\_STR\_MATCH checks, when applicable. |
| <a name="output_tags"></a> [tags](#output\_tags) | Map of explicitly configured tags on the health check. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | Map of tags assigned to the health check including provider default tags. |
| <a name="output_type"></a> [type](#output\_type) | The health check type. |
<!-- END_TF_DOCS -->
