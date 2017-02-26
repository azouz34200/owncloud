resource "aws_db_instance" "db_oc" {
    identifier                = "db-oc-${var.env}"
    allocated_storage         = "${var.db_storage_size}"
    storage_type              = "${var.db_storage_type}"
    engine                    = "${var.db_engine}"
    engine_version            = "${var.db_engine_version}"
    instance_class            = "${var.db_instance_class}"
    name                      = "${var.db_name}"
    username                  = "${var.db_user}"
    password                  = "${var.db_password}"
    port                      = "${var.db_port}"
    publicly_accessible       = "${var.db_public_access}"
    #availability_zone         = ["eu-west-1a","u-west-1b","u-west-1c"]
    security_group_names      = []
    vpc_security_group_ids    = ["${var.db_vpc_security_group_ids}"]
    db_subnet_group_name      = "${var.db_subnet_group_name}"
    parameter_group_name      = "${var.db_parameter_group_name}"
    multi_az                  = "${var.db_multi_az}"
    backup_retention_period   = "${var.db_backup_retention_period}"
    backup_window             = "${var.db_backup_window}"
    maintenance_window        = "${var.db_maintenance_window}"
    final_snapshot_identifier = "${var.db_final_snapshot_identifier}"
}
