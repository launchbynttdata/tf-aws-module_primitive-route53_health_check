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
  description = "Health check protocol/type. Valid values: HTTP, HTTPS, HTTP_STR_MATCH, HTTPS_STR_MATCH, TCP, CALCULATED, CLOUDWATCH_METRIC, RECOVERY_CONTROL."
  type        = string

  validation {
    condition = contains([
      "HTTP",
      "HTTPS",
      "HTTP_STR_MATCH",
      "HTTPS_STR_MATCH",
      "TCP",
      "CALCULATED",
      "CLOUDWATCH_METRIC",
      "RECOVERY_CONTROL"
    ], var.type)
    error_message = "type must be one of HTTP, HTTPS, HTTP_STR_MATCH, HTTPS_STR_MATCH, TCP, CALCULATED, CLOUDWATCH_METRIC, or RECOVERY_CONTROL."
  }
}

variable "fqdn" {
  description = "Fully-qualified domain name of the endpoint to check."
  type        = string
  default     = null
}

variable "ip_address" {
  description = "IPv4 or IPv6 address of the endpoint to check."
  type        = string
  default     = null
}

variable "port" {
  description = "Port on the endpoint to check."
  type        = number
  default     = null

  validation {
    condition     = var.port == null ? true : (var.port >= 1 && var.port <= 65535)
    error_message = "port must be between 1 and 65535."
  }
}

variable "request_interval" {
  description = "Seconds between health checks. Valid values: 10 or 30."
  type        = number
  default     = null

  validation {
    condition     = var.request_interval == null ? true : contains([10, 30], var.request_interval)
    error_message = "request_interval must be either 10 or 30."
  }
}

variable "failure_threshold" {
  description = "Consecutive health check failures required before status changes."
  type        = number
  default     = null

  validation {
    condition     = var.failure_threshold == null ? true : (var.failure_threshold >= 1 && var.failure_threshold <= 10)
    error_message = "failure_threshold must be between 1 and 10."
  }
}

variable "resource_path" {
  description = "Path Route 53 requests for HTTP/HTTPS checks (for example, /healthz)."
  type        = string
  default     = null
}

variable "search_string" {
  description = "String to match in the first 5120 bytes of response body for *_STR_MATCH types."
  type        = string
  default     = null
}

variable "measure_latency" {
  description = "Whether Route 53 should measure/check latency for this endpoint."
  type        = bool
  default     = null
}

variable "invert_healthcheck" {
  description = "Whether Route 53 should invert the evaluated health status."
  type        = bool
  default     = null
}

variable "disabled" {
  description = "Whether Route 53 should stop performing checks and report healthy."
  type        = bool
  default     = null
}

variable "enable_sni" {
  description = "Whether HTTPS checks should include SNI in TLS client hello."
  type        = bool
  default     = null
}

variable "child_healthchecks" {
  description = "Child health check IDs for CALCULATED checks."
  type        = set(string)
  default     = null

  validation {
    condition     = var.child_healthchecks == null ? true : length(var.child_healthchecks) > 0
    error_message = "child_healthchecks must contain at least one health check ID when set."
  }
}

variable "child_health_threshold" {
  description = "Minimum number of healthy child checks required for CALCULATED checks."
  type        = number
  default     = null

  validation {
    condition     = var.child_health_threshold == null ? true : (var.child_health_threshold >= 0 && var.child_health_threshold <= 256)
    error_message = "child_health_threshold must be between 0 and 256."
  }
}

variable "cloudwatch_alarm_name" {
  description = "CloudWatch alarm name for CLOUDWATCH_METRIC checks."
  type        = string
  default     = null
}

variable "cloudwatch_alarm_region" {
  description = "AWS region of the CloudWatch alarm for CLOUDWATCH_METRIC checks."
  type        = string
  default     = null
}

variable "insufficient_data_health_status" {
  description = "Health status when CloudWatch alarm data is insufficient: Healthy, Unhealthy, or LastKnownStatus."
  type        = string
  default     = null

  validation {
    condition = var.insufficient_data_health_status == null ? true : contains([
      "Healthy",
      "Unhealthy",
      "LastKnownStatus"
    ], var.insufficient_data_health_status)
    error_message = "insufficient_data_health_status must be Healthy, Unhealthy, or LastKnownStatus."
  }
}

variable "regions" {
  description = "Optional set of AWS regions from which Route 53 performs endpoint checks. When set, Route 53 requires at least three regions."
  type        = set(string)
  default     = null

  validation {
    condition     = var.regions == null || length(var.regions) >= 3
    error_message = "When regions is set, it must contain at least three AWS regions."
  }
}

variable "reference_name" {
  description = "Optional caller reference name used by Route 53 for this health check."
  type        = string
  default     = null

  validation {
    condition     = var.reference_name == null ? true : length(var.reference_name) <= 64
    error_message = "reference_name must be 64 characters or fewer."
  }
}

variable "routing_control_arn" {
  description = "Route 53 Application Recovery Controller routing control ARN for RECOVERY_CONTROL checks."
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of tags to assign to the health check."
  type        = map(string)
  default     = {}
}

variable "triggers" {
  description = "Arbitrary map of values that, when changed, force replacement."
  type        = map(string)
  default     = null
}
