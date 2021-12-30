data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}

data "aws_security_group" "selected" {
  id = module.web_server_sg.security_group_id
}


