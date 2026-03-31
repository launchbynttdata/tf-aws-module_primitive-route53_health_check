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
  description = "The Route 53 health check ID."
  value       = aws_route53_health_check.health_check.id
}

output "arn" {
  description = "The ARN of the Route 53 health check."
  value       = aws_route53_health_check.health_check.arn
}

output "type" {
  description = "The health check type."
  value       = aws_route53_health_check.health_check.type
}

output "fqdn" {
  description = "The configured endpoint FQDN, when applicable."
  value       = aws_route53_health_check.health_check.fqdn
}

output "ip_address" {
  description = "The configured endpoint IP address, when applicable."
  value       = aws_route53_health_check.health_check.ip_address
}

output "port" {
  description = "The configured endpoint port, when applicable."
  value       = aws_route53_health_check.health_check.port
}

output "request_interval" {
  description = "The request interval in seconds."
  value       = aws_route53_health_check.health_check.request_interval
}

output "failure_threshold" {
  description = "The failure threshold used by the health check."
  value       = aws_route53_health_check.health_check.failure_threshold
}

output "resource_path" {
  description = "The configured resource path for HTTP/HTTPS checks, when applicable."
  value       = aws_route53_health_check.health_check.resource_path
}

output "search_string" {
  description = "The configured search string for *_STR_MATCH checks, when applicable."
  value       = aws_route53_health_check.health_check.search_string
}

output "measure_latency" {
  description = "Whether latency measurements are enabled."
  value       = aws_route53_health_check.health_check.measure_latency
}

output "invert_healthcheck" {
  description = "Whether health check status inversion is enabled."
  value       = aws_route53_health_check.health_check.invert_healthcheck
}

output "disabled" {
  description = "Whether the health check is disabled."
  value       = aws_route53_health_check.health_check.disabled
}

output "enable_sni" {
  description = "Whether SNI is enabled for HTTPS checks."
  value       = aws_route53_health_check.health_check.enable_sni
}

output "child_healthchecks" {
  description = "Child health check IDs configured for CALCULATED checks."
  value       = aws_route53_health_check.health_check.child_healthchecks
}

output "child_health_threshold" {
  description = "Child health threshold configured for CALCULATED checks."
  value       = aws_route53_health_check.health_check.child_health_threshold
}

output "cloudwatch_alarm_name" {
  description = "CloudWatch alarm name configured for CLOUDWATCH_METRIC checks."
  value       = aws_route53_health_check.health_check.cloudwatch_alarm_name
}

output "cloudwatch_alarm_region" {
  description = "CloudWatch alarm region configured for CLOUDWATCH_METRIC checks."
  value       = aws_route53_health_check.health_check.cloudwatch_alarm_region
}

output "insufficient_data_health_status" {
  description = "Health status used when CloudWatch alarm data is insufficient."
  value       = aws_route53_health_check.health_check.insufficient_data_health_status
}

output "regions" {
  description = "Regions configured for endpoint checks."
  value       = aws_route53_health_check.health_check.regions
}

output "reference_name" {
  description = "Route 53 caller reference name for the health check."
  value       = aws_route53_health_check.health_check.reference_name
}

output "routing_control_arn" {
  description = "Routing control ARN configured for RECOVERY_CONTROL checks."
  value       = aws_route53_health_check.health_check.routing_control_arn
}

output "tags" {
  description = "Map of explicitly configured tags on the health check."
  value       = aws_route53_health_check.health_check.tags
}

output "tags_all" {
  description = "Map of tags assigned to the health check including provider default tags."
  value       = aws_route53_health_check.health_check.tags_all
}
