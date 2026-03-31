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

resource "aws_route53_health_check" "health_check" {
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
  triggers                        = var.triggers
  tags                            = var.tags

  lifecycle {
    precondition {
      condition = contains(["HTTP", "HTTPS", "HTTP_STR_MATCH", "HTTPS_STR_MATCH", "TCP"], var.type) ? (
        var.fqdn != null || var.ip_address != null
      ) : true
      error_message = "Endpoint checks (HTTP/HTTPS/*_STR_MATCH/TCP) require fqdn or ip_address."
    }

    precondition {
      condition = contains(["HTTP_STR_MATCH", "HTTPS_STR_MATCH"], var.type) ? (
        var.search_string != null
      ) : var.search_string == null
      error_message = "search_string is required for *_STR_MATCH checks and must be null for other types."
    }

    precondition {
      condition = var.type == "CLOUDWATCH_METRIC" ? (
        var.cloudwatch_alarm_name != null && var.cloudwatch_alarm_region != null
        ) : (
        var.cloudwatch_alarm_name == null &&
        var.cloudwatch_alarm_region == null &&
        var.insufficient_data_health_status == null
      )
      error_message = "CLOUDWATCH_METRIC checks require cloudwatch_alarm_name and cloudwatch_alarm_region; those fields are invalid for other types."
    }

    precondition {
      condition = var.type == "CALCULATED" ? (
        var.child_healthchecks != null && var.child_health_threshold != null
        ) : (
        var.child_healthchecks == null && var.child_health_threshold == null
      )
      error_message = "CALCULATED checks require child_healthchecks and child_health_threshold; those fields are invalid for other types."
    }

    precondition {
      condition = var.type == "RECOVERY_CONTROL" ? (
        var.routing_control_arn != null
      ) : var.routing_control_arn == null
      error_message = "routing_control_arn is required for RECOVERY_CONTROL checks and must be null for other types."
    }

    precondition {
      condition = contains(["CLOUDWATCH_METRIC", "CALCULATED", "RECOVERY_CONTROL"], var.type) ? (
        var.port == null
      ) : true
      error_message = "port must be null for CLOUDWATCH_METRIC, CALCULATED, and RECOVERY_CONTROL checks."
    }

    precondition {
      condition     = var.enable_sni == null ? true : contains(["HTTPS", "HTTPS_STR_MATCH"], var.type)
      error_message = "enable_sni is only valid for HTTPS and HTTPS_STR_MATCH checks."
    }

    precondition {
      condition     = var.resource_path == null ? true : contains(["HTTP", "HTTPS", "HTTP_STR_MATCH", "HTTPS_STR_MATCH"], var.type)
      error_message = "resource_path is only valid for HTTP, HTTPS, HTTP_STR_MATCH, and HTTPS_STR_MATCH checks."
    }
  }
}
