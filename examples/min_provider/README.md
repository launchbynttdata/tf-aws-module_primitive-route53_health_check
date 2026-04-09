# min_provider

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.10 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_route53_health_check"></a> [route53\_health\_check](#module\_route53\_health\_check) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_child_health_threshold"></a> [child\_health\_threshold](#input\_child\_health\_threshold) | Minimum healthy child checks required for CALCULATED checks. | `number` | `null` | no |
| <a name="input_child_healthchecks"></a> [child\_healthchecks](#input\_child\_healthchecks) | Child health check IDs for CALCULATED checks. | `set(string)` | `null` | no |
| <a name="input_cloudwatch_alarm_name"></a> [cloudwatch\_alarm\_name](#input\_cloudwatch\_alarm\_name) | CloudWatch alarm name for CLOUDWATCH\_METRIC checks. | `string` | `null` | no |
| <a name="input_cloudwatch_alarm_region"></a> [cloudwatch\_alarm\_region](#input\_cloudwatch\_alarm\_region) | CloudWatch alarm region for CLOUDWATCH\_METRIC checks. | `string` | `null` | no |
| <a name="input_disabled"></a> [disabled](#input\_disabled) | Whether the health check is disabled. | `bool` | `null` | no |
| <a name="input_enable_sni"></a> [enable\_sni](#input\_enable\_sni) | Whether to enable SNI for HTTPS checks. | `bool` | `null` | no |
| <a name="input_failure_threshold"></a> [failure\_threshold](#input\_failure\_threshold) | Consecutive failure threshold before unhealthy status. | `number` | `null` | no |
| <a name="input_fqdn"></a> [fqdn](#input\_fqdn) | Fully-qualified endpoint domain name. | `string` | `null` | no |
| <a name="input_insufficient_data_health_status"></a> [insufficient\_data\_health\_status](#input\_insufficient\_data\_health\_status) | Status when CloudWatch alarm data is insufficient. | `string` | `null` | no |
| <a name="input_invert_healthcheck"></a> [invert\_healthcheck](#input\_invert\_healthcheck) | Whether to invert evaluated health status. | `bool` | `null` | no |
| <a name="input_ip_address"></a> [ip\_address](#input\_ip\_address) | Endpoint IP address. | `string` | `null` | no |
| <a name="input_measure_latency"></a> [measure\_latency](#input\_measure\_latency) | Whether to enable latency measurement. | `bool` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | Endpoint port. | `number` | `null` | no |
| <a name="input_reference_name"></a> [reference\_name](#input\_reference\_name) | Optional Route 53 reference name. | `string` | `null` | no |
| <a name="input_regions"></a> [regions](#input\_regions) | Optional set of regions for endpoint checks. When set, Route 53 requires at least three regions. | `set(string)` | `null` | no |
| <a name="input_request_interval"></a> [request\_interval](#input\_request\_interval) | Route 53 request interval in seconds. | `number` | `null` | no |
| <a name="input_resource_path"></a> [resource\_path](#input\_resource\_path) | Path to probe for HTTP/HTTPS checks. | `string` | `null` | no |
| <a name="input_routing_control_arn"></a> [routing\_control\_arn](#input\_routing\_control\_arn) | Routing control ARN for RECOVERY\_CONTROL checks. | `string` | `null` | no |
| <a name="input_search_string"></a> [search\_string](#input\_search\_string) | String to match for *\_STR\_MATCH checks. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the health check. | `map(string)` | `{}` | no |
| <a name="input_triggers"></a> [triggers](#input\_triggers) | Map of values that force replacement when changed. | `map(string)` | `null` | no |
| <a name="input_type"></a> [type](#input\_type) | Health check protocol/type. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Health check ARN. |
| <a name="output_child_health_threshold"></a> [child\_health\_threshold](#output\_child\_health\_threshold) | Configured child health threshold for CALCULATED checks. |
| <a name="output_child_healthchecks"></a> [child\_healthchecks](#output\_child\_healthchecks) | Configured child health check IDs for CALCULATED checks. |
| <a name="output_cloudwatch_alarm_name"></a> [cloudwatch\_alarm\_name](#output\_cloudwatch\_alarm\_name) | Configured CloudWatch alarm name for CLOUDWATCH\_METRIC checks. |
| <a name="output_cloudwatch_alarm_region"></a> [cloudwatch\_alarm\_region](#output\_cloudwatch\_alarm\_region) | Configured CloudWatch alarm region for CLOUDWATCH\_METRIC checks. |
| <a name="output_disabled"></a> [disabled](#output\_disabled) | Whether the health check is disabled. |
| <a name="output_enable_sni"></a> [enable\_sni](#output\_enable\_sni) | Whether SNI is enabled. |
| <a name="output_expected_tags"></a> [expected\_tags](#output\_expected\_tags) | Expected tag map from example input. |
| <a name="output_failure_threshold"></a> [failure\_threshold](#output\_failure\_threshold) | Configured failure threshold. |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | Configured endpoint FQDN. |
| <a name="output_id"></a> [id](#output\_id) | Health check ID. |
| <a name="output_insufficient_data_health_status"></a> [insufficient\_data\_health\_status](#output\_insufficient\_data\_health\_status) | Configured insufficient data health status for CLOUDWATCH\_METRIC checks. |
| <a name="output_invert_healthcheck"></a> [invert\_healthcheck](#output\_invert\_healthcheck) | Whether health status inversion is enabled. |
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | Configured endpoint IP address. |
| <a name="output_measure_latency"></a> [measure\_latency](#output\_measure\_latency) | Whether latency measurement is enabled. |
| <a name="output_port"></a> [port](#output\_port) | Configured endpoint port. |
| <a name="output_reference_name"></a> [reference\_name](#output\_reference\_name) | Configured Route 53 caller reference name. |
| <a name="output_regions"></a> [regions](#output\_regions) | Configured checker regions. |
| <a name="output_request_interval"></a> [request\_interval](#output\_request\_interval) | Configured request interval. |
| <a name="output_resource_path"></a> [resource\_path](#output\_resource\_path) | Configured HTTP/HTTPS resource path. |
| <a name="output_routing_control_arn"></a> [routing\_control\_arn](#output\_routing\_control\_arn) | Configured routing control ARN for RECOVERY\_CONTROL checks. |
| <a name="output_search_string"></a> [search\_string](#output\_search\_string) | Configured search string for *\_STR\_MATCH checks. |
| <a name="output_tags"></a> [tags](#output\_tags) | Configured tags on the health check. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | All tags on the health check including provider default tags. |
| <a name="output_type"></a> [type](#output\_type) | Health check type. |
<!-- END_TF_DOCS -->
