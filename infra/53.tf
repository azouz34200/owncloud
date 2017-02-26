resource "aws_route53_record" "owncloud" {
   zone_id = "${var.route53_zoneid}"
   name = "${var.site}"
   type = "A"
   alias {
     name = "${aws_alb.alb-oc.dns_name}"
     zone_id = "${aws_alb.alb-oc.zone_id}"
     evaluate_target_health = true
   }
}
