variable "environment" {
  description = "Environment tag, e.g prod"
  default     = "prod"
}

variable "s3_bucket_workshop"{
   default = "cloudone-india-workshop"
}

variable "name" {
  description = "Name tag, e.g stack"
  default     = "vpc"
}

variable "code" {
  #default     = "00"
}

resource "random_id" "r" {
  byte_length = 4
}

variable "admin_ips" {
  default = ["13.251.179.209/32", "203.27.184.158/32", "103.252.203.102/32"]
}

variable "eks_instances" {
  default = "2"
}


variable "eks_instance_type" {
  default = "t3.medium"
}
