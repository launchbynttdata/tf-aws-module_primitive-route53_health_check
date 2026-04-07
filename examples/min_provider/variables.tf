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

variable "type" {
  description = "Health check protocol/type."
  type        = string
}

variable "fqdn" {
  description = "Fully-qualified endpoint domain name."
  type        = string
  default     = null
}

variable "ip_address" {
  description = "Endpoint IP address."
  type        = string
  default     = null
}

variable "port" {
  description = "Endpoint port."
  type        = number
  default     = null
}

variable "request_interval" {
  description = "Route 53 request interval in seconds."
  type        = number
  default     = null
}

variable "failure_threshold" {
  description = "Consecutive failure threshold before unhealthy status."
  type        = number
  default     = null
}

variable "resource_path" {
  description = "Path to probe for HTTP/HTTPS checks."
  type        = string
  default     = null
}

variable "search_string" {
  description = "String to match for *_STR_MATCH checks."
  type        = string
  default     = null
}

variable "measure_latency" {
  description = "Whether to enable latency measurement."
  type        = bool
  default     = null
}

variable "invert_healthcheck" {
  description = "Whether to invert evaluated health status."
  type        = bool
  default     = null
}

variable "disabled" {
  description = "Whether the health check is disabled."
  type        = bool
  default     = null
}

variable "enable_sni" {
  description = "Whether to enable SNI for HTTPS checks."
  type        = bool
  default     = null
}

variable "child_healthchecks" {
  description = "Child health check IDs for CALCULATED checks."
  type        = set(string)
  default     = null
}

variable "child_health_threshold" {
  description = "Minimum healthy child checks required for CALCULATED checks."
  type        = number
  default     = null
}

variable "cloudwatch_alarm_name" {
  description = "CloudWatch alarm name for CLOUDWATCH_METRIC checks."
  type        = string
  default     = null
}

variable "cloudwatch_alarm_region" {
  description = "CloudWatch alarm region for CLOUDWATCH_METRIC checks."
  type        = string
  default     = null
}

variable "insufficient_data_health_status" {
  description = "Status when CloudWatch alarm data is insufficient."
  type        = string
  default     = null
}

variable "regions" {
  description = "Optional set of regions for endpoint checks. When set, Route 53 requires at least three regions."
  type        = set(string)
  default     = null
}

variable "reference_name" {
  description = "Optional Route 53 reference name."
  type        = string
  default     = null
}

variable "routing_control_arn" {
  description = "Routing control ARN for RECOVERY_CONTROL checks."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to assign to the health check."
  type        = map(string)
  default     = {}
}

variable "triggers" {
  description = "Map of values that force replacement when changed."
  type        = map(string)
  default     = null
}
