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
