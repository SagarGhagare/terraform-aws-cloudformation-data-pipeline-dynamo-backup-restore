# CloudFormation stacks for data pipeline
data "template_file" "data_pipeline_dynamo_backup_template" {
    template = "${file("${path.module}/datapipeline-backup-dynamo-cf.json")}"

    vars {
        table_name              = "${var.table_name}"
        table_region            = "${var.region}"
        read_throughput_ratio   = "${var.read_throughput_ratio}"
        subnet_id               = "${var.subnet_id}"
        terminate_after         = "${var.terminate_after}"
        s3_bucket               = "${var.s3_bucket}"
        schedule_period         = "${var.schedule}"
        sns_topic_arn           = "${var.sns_topic_arn}"
        environment             = "${var.environment}"
        default_role            = "${var.default_role}"
        resource_role           = "${var.resource_role}"
    }
}

data "template_file" "data_pipeline_dynamo_restore_template" {
    template = "${file("${path.module}/datapipeline-restore-dynamo-cf.json")}"

    vars {
        table_name              = "${var.table_name}"
        table_region            = "${var.region}"
        write_throughput_ratio  = "${var.write_throughput_ratio}"
        subnet_id               = "${var.subnet_id}"
        terminate_after         = "${var.terminate_after}"
        s3_bucket               = "${var.s3_bucket}"
        sns_topic_arn           = "${var.sns_topic_arn}"
        environment             = "${var.environment}"
        default_role            = "${var.default_role}"
        resource_role           = "${var.resource_role}"
    }
}

# Has to be in eu-west-1, not our normal region
resource "aws_cloudformation_stack" "module_data_pipeline_backup_stack" {
    provider = "aws.ireland"
    name     = "${var.environment}-${var.region}-datapipeline-backup-${var.table_name}"
    count    = "${var.data_pipeline_toggle}"
    template_body = "${data.template_file.data_pipeline_dynamo_backup_template.rendered}"
}

resource "aws_cloudformation_stack" "module_data_pipeline_restore_stack" {
    provider = "aws.ireland"
    name     = "${var.environment}-${var.region}-datapipeline-restore-${var.table_name}"
    count    = "${var.data_pipeline_toggle}"
    template_body = "${data.template_file.data_pipeline_dynamo_restore_template.rendered}"
}

