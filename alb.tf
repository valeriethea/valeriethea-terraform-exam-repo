module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "web-app-alb"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = [module.vpc.private_subnets[0], module.vpc.public_subnets[1]]
  security_groups = [module.web_server_sg.security_group_id]

  target_groups = [
    {
      name_prefix      = "l1-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = [
        {
          target_id = ""
          port      = 80
        },
        {
          target_id = ""
          port      = 8080
        }
      ]
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "dev"
  }
}