module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.9.0"
  cidr    = "10.0.0.0/16"
  azs     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  name    = "${var.code}-eks"
  tags = {
    name   = "${var.name}-eks"
    monaco = "${var.name}"
	
  }

  vpc_tags = {
    name   = "${var.name}-eks"
    monaco = "${var.name}"
  }
  public_subnets = ["10.0.96.0/20", "10.0.112.0/20", "10.0.128.0/20"]
  public_subnet_tags = {
	"KubernetesCluster" = "${var.code}"
	"kubernetes.io/role/elb" = 1
  }
  

}

#module "vpc" {
#  source      = "../vpc_simple"
#  name        = "${var.name}"
#  environment = "${var.environment}"
#  code        = "${var.code}"
#}

#module "ecs" {
#  source = "../ecs"
#  name        = "${var.name}"
#  environment = "${var.environment}"
#  subnet_ids  = "${module.vpc.external_subnets}"
#  vpc_id      = "${module.vpc.id}"
#  admin_ips   = ["${var.admin_ips}"]
#  cidr        = "192.168.0.0/16"
#  dsmurl      = "dsm.brycehawk.com"
#  dsmpolicy = "13"
#}


