
output "alb-dns-dev" {
  value="${aws_alb.alb-oc-dev.dns_name}"
}

output "db_dns-dev"{

  value="${aws_db_instance.db_oc_dev.address}"
}
