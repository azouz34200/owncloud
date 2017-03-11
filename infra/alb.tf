resource "aws_alb" "alb-oc" {
    idle_timeout    = 60
    internal        = false
    name            = "alb-oc-${var.env}"
    security_groups = ["${var.alb_security_groups}"]
    subnets         = ["${var.id_subnet_a}", "${var.id_subnet_b}", "${var.id_subnet_c}"]

    enable_deletion_protection = false

    tags {
      "env" = "${var.env}"
    }
}

resource "aws_alb_target_group" "gp-oc" {
  name     = "alb-gp-oc-${var.env}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.id_vpc_main}"
  tags {
      "env" = "${var.env}"
  }
  stickiness{
  type = "lb_cookie"
  enabled = true
  cookie_duration = 86400

}
health_check {
  healthy_threshold   = 5
  unhealthy_threshold = 2
  timeout             = 5
  interval            = 30
  path                = "${var.health_check_path}"
  protocol            = "HTTP"
  port                = 80
}

}

resource "aws_alb_listener" "oc-front-end" {
  load_balancer_arn = "${aws_alb.alb-oc.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.gp-oc.id}"
    type             = "forward"
  }
}
resource "aws_alb_target_group_attachment" "gp_attach_oc2" {
  target_group_arn = "${aws_alb_target_group.gp-oc.arn}"
  target_id = "${var.ec2_instance1}"
  port = 80
}
resource "aws_alb_listener" "oc-front-end-ssl" {
  load_balancer_arn = "${aws_alb.alb-oc.id}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2015-05"
  certificate_arn = "${data.aws_acm_certificate.certificate.arn}"
  default_action {
    target_group_arn = "${aws_alb_target_group.gp-oc.id}"
    type             = "forward"
  }
}
resource "aws_alb_target_group_attachment" "gp_attach_oc" {
  target_group_arn = "${aws_alb_target_group.gp-oc.arn}"
  target_id = "${var.ec2_instance2}"
  port= 80
}
