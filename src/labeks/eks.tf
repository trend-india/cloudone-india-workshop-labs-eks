data "aws_eks_cluster" "cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.my-cluster.cluster_id
}


data "aws_iam_user" "eks_user" {
  user_name = "my-${var.name}"
}

data "aws_iam_role" "eks_role" {
  name = "monaco-${var.name}"
}


provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.code
  cluster_version = "1.16"
  subnets         = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id

  worker_groups = [
    {
      instance_type        = var.eks_instance_type
      asg_max_size         = var.eks_instances
      asg_min_size         = var.eks_instances
      asg_desired_capacity = var.eks_instances
      root_volume_type = "gp2"
    }
  ]

    map_roles = [
    {
      rolearn = "${data.aws_iam_role.eks_role.arn}"
      username = "monaco-${var.name}-role"
      groups   = ["system:masters"]
    },
  ]

    tags = {
    name   = "${var.name}-eks"
    monaco = "${var.name}"
  }
}