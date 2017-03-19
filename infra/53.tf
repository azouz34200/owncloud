resource "aws_route53_record" "owncloud" {
  zone_id = "${var.route53_zoneid}"
  name    = "${var.site}"
  type    = "A"

  alias {
    name                   = "${aws_alb.alb-oc.dns_name}"
    zone_id                = "${aws_alb.alb-oc.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_health_check" "owncloud" {
  fqdn              = "${var.site}"
  port              = 443
  type              = "HTTPS"
  resource_path     = "${var.health_check_path}"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = "owncloud-health-check-${var.env}"
  }
}
