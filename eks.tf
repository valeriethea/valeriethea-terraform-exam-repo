module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_version = "1.21"
  cluster_name    = "my-cluster-demo"
  vpc_id          = module.vpc.vpc_id
  subnets         = [module.vpc.private_subnets[0], module.vpc.public_subnets[1]]

  worker_groups = [
    {
      name                 = "worker-group-demo"
      instance_type        = "t3.medium"
      asg_desired_capacity = 2
    },
  ]
}