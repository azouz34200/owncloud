data "aws_acm_certificate" "certificate" {
  domain = "${var.site}"
  statuses = ["ISSUED"]
}
