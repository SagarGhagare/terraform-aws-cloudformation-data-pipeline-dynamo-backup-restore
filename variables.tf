variable "table_name" {
  description = "The name of the DynamoDB table to backup and restore"
}

variable "region" {
  description = "The region of the DynamoDB table"
  default = "eu-west-2"
}

variable "read_throughput_ratio" {
  description = "The ratio of the tables read throughput to use when backing up"
  default = "0.25"
}

variable "write_throughput_ratio" {
  description = "The ratio of the tables write throughput to use when restoring"
  default = "0.25"
}

variable "subnet_id" {
  description = "The subnet to deploy the EMR cluster into - M4 instances must be in a subnet"
}

variable "terminate_after" {
  description = "The time after which the cluster should be terminated to prevent it hanging"
  default = "3 Hours"
}

variable "schedule" {
  description = "The schedule at which to run the backup process"
  default = "3 Hours"
}

variable "sns_topic_arn" {
  description = "The ARN of the SNS topic the pipeline will publish errors to"
}

variable "s3_bucket" {
  description = "The bucket where the backups and the EMR logs will be stored"
}

variable "environment" {
  description = "The environment the backup and restore is for"
}

variable "default_role" {
  description = "The name of the IAM role for the data pipeline"
}

variable "default_role_policy_id" {
  description = "Policy id to force dependency between DataPipeline and required role"
}

variable "resource_role" {
  description = "The name of the IAM role for resources created by the data pipeline"
}

variable "resource_role_policy_id" {
  description = "Policy id to force dependency between DataPipeline and required role"
}

variable "data_pipeline_toggle" {
  description = "Toggle to enable data_pipeline configuration"
}



