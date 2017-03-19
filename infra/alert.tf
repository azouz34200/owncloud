resource "aws_cloudwatch_metric_alarm" "Average-CPU-Utilisation-Pran01" {
  alarm_name          = "Average CPU Utilisation Pran01"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.ec2_threshold}"
  alarm_description   = ""
  alarm_actions       = ["${aws_sns_topic.owncloud.arn}"]

  dimensions {
    InstanceId = "${var.ec2_instance1}"
  }
}

resource "aws_cloudwatch_metric_alarm" "Average-CPU-Utilisation-Pran02" {
  alarm_name          = "Average CPU Utilisation Pran02"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.ec2_threshold}"
  alarm_description   = ""
  alarm_actions       = ["${aws_sns_topic.owncloud.arn}"]

  dimensions {
    InstanceId = "${var.ec2_instance2}"
  }
}

resource "aws_cloudwatch_metric_alarm" "DB-OC-Utilisation-Prod" {
  alarm_name          = "Average CPU Utilisation ${var.env} ${var.db_name}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "90.0"
  alarm_description   = ""
  alarm_actions       = ["${aws_sns_topic.owncloud.arn}"]

  dimensions {
    EngineName = "mariadb"
  }
}

resource "aws_cloudwatch_metric_alarm" "Db-Storage-owncloud" {
  alarm_name          = "Db Storage owncloud"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "3.0"
  alarm_description   = ""
  alarm_actions       = ["${aws_sns_topic.owncloud.arn}"]

  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.db_oc.identifier}"
  }
}

resource "aws_cloudwatch_metric_alarm" "Lost-rancher-instance" {
  alarm_name          = "Lost rancher instance"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "2.0"
  alarm_description   = "Lost rancher instance"
  alarm_actions       = ["${aws_sns_topic.owncloud.arn}"]

  dimensions {
    LoadBalancer = "${aws_alb.alb-oc.arn_suffix}"
    TargetGroup  = "${aws_alb_target_group.gp-oc.arn_suffix}"
  }
}
