type                            = "HTTPS"
fqdn                            = "aws.amazon.com"
ip_address                      = null
port                            = 443
request_interval                = 30
failure_threshold               = 3
resource_path                   = "/"
search_string                   = null
measure_latency                 = true
invert_healthcheck              = false
disabled                        = false
enable_sni                      = true
child_healthchecks              = null
child_health_threshold          = null
cloudwatch_alarm_name           = null
cloudwatch_alarm_region         = null
insufficient_data_health_status = null
regions                         = ["us-east-1", "us-west-2", "eu-west-1"]
reference_name                  = null
routing_control_arn             = null
triggers                        = null

tags = {
  Example = "complete"
}
