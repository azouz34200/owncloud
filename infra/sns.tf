resource "aws_sns_topic" "owncloud" {
  name = "owncloud-topic-${var.env}"
}

resource "aws_sns_topic_subscription" "owncloud_subscription" {
  topic_arn              = "${aws_sns_topic.owncloud.arn}"
  protocol               = "https"
  endpoint               = "${var.endpoint_slack}"
  endpoint_auto_confirms = true
}
