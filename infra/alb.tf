resource "aws_alb" "alb-oc-dev" {
    idle_timeout    = 60
    internal        = false
    name            = "alb-oc-dev"
    security_groups = ["${var.security_groups}"]
    subnets         = ["${var.id_subnet_a_dev}", "${var.id_subnet_b_dev}", "${var.id_subnet_c_dev}"]

    enable_deletion_protection = false

    tags {
        "env" = "d"
    }
}

resource "aws_alb_target_group" "gp-oc" {
  name     = "alb-gp-oc-dev"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.id_vpc_main_dev}"
  tags {
      "env" = "d"
  }
  stickiness{
  type = "lb_cookie"
  enabled = true
  cookie_duration = 86400

}


}

resource "aws_alb_listener" "oc-front-end" {
  load_balancer_arn = "${aws_alb.alb-oc-dev.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.gp-oc.id}"
    type             = "forward"
  }
}
resource "aws_alb_target_group_attachment" "gp_attach_oc2_dev" {
  target_group_arn = "${aws_alb_target_group.gp-oc.arn}"
  target_id = "${var.ec2_instance1}"
  port = 80
}
resource "aws_alb_target_group_attachment" "gp_attach_oc_dev" {
  target_group_arn = "${aws_alb_target_group.gp-oc.arn}"
  target_id = "${var.ec2_instance2}"
  port= 80
}
