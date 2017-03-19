output "alb-dns" {
  value = "${aws_alb.alb-oc.dns_name}"
}

output "db_dns" {
  value = "${aws_db_instance.db_oc.address}"
}

output "alb_arn" {
  value = "${aws_alb.alb-oc.arn}"
}
