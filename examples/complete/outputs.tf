// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

output "id" {
  description = "Health check ID."
  value       = module.route53_health_check.id
}

output "arn" {
  description = "Health check ARN."
  value       = module.route53_health_check.arn
}

output "type" {
  description = "Health check type."
  value       = module.route53_health_check.type
}

output "fqdn" {
  description = "Configured endpoint FQDN."
  value       = module.route53_health_check.fqdn
}

output "ip_address" {
  description = "Configured endpoint IP address."
  value       = module.route53_health_check.ip_address
}

output "port" {
  description = "Configured endpoint port."
  value       = module.route53_health_check.port
}

output "request_interval" {
  description = "Configured request interval."
  value       = module.route53_health_check.request_interval
}

output "failure_threshold" {
  description = "Configured failure threshold."
  value       = module.route53_health_check.failure_threshold
}

output "resource_path" {
  description = "Configured HTTP/HTTPS resource path."
  value       = module.route53_health_check.resource_path
}

output "search_string" {
  description = "Configured search string for *_STR_MATCH checks."
  value       = module.route53_health_check.search_string
}

output "measure_latency" {
  description = "Whether latency measurement is enabled."
  value       = module.route53_health_check.measure_latency
}

output "invert_healthcheck" {
  description = "Whether health status inversion is enabled."
  value       = module.route53_health_check.invert_healthcheck
}

output "disabled" {
  description = "Whether the health check is disabled."
  value       = module.route53_health_check.disabled
}

output "enable_sni" {
  description = "Whether SNI is enabled."
  value       = module.route53_health_check.enable_sni
}

output "child_healthchecks" {
  description = "Configured child health check IDs for CALCULATED checks."
  value       = module.route53_health_check.child_healthchecks
}

output "child_health_threshold" {
  description = "Configured child health threshold for CALCULATED checks."
  value       = module.route53_health_check.child_health_threshold
}

output "cloudwatch_alarm_name" {
  description = "Configured CloudWatch alarm name for CLOUDWATCH_METRIC checks."
  value       = module.route53_health_check.cloudwatch_alarm_name
}

output "cloudwatch_alarm_region" {
  description = "Configured CloudWatch alarm region for CLOUDWATCH_METRIC checks."
  value       = module.route53_health_check.cloudwatch_alarm_region
}

output "insufficient_data_health_status" {
  description = "Configured insufficient data health status for CLOUDWATCH_METRIC checks."
  value       = module.route53_health_check.insufficient_data_health_status
}

output "regions" {
  description = "Configured checker regions."
  value       = module.route53_health_check.regions
}

output "reference_name" {
  description = "Configured Route 53 caller reference name."
  value       = module.route53_health_check.reference_name
}

output "routing_control_arn" {
  description = "Configured routing control ARN for RECOVERY_CONTROL checks."
  value       = module.route53_health_check.routing_control_arn
}

output "tags" {
  description = "Configured tags on the health check."
  value       = module.route53_health_check.tags
}

output "tags_all" {
  description = "All tags on the health check including provider default tags."
  value       = module.route53_health_check.tags_all
}

output "expected_tags" {
  description = "Expected tag map from example input."
  value       = var.tags
}
