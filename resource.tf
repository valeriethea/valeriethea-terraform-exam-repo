resource "aws_key_pair" "demo" {
  key_name   = var.key_name
  public_key = var.public_key
}

#Creating EC2 Instance
resource "aws_instance" "ec2-demo" {
  vpc_security_group_ids = [module.web_server_sg.security_group_id]
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.medium"
  subnet_id              = element(module.vpc.private_subnets, 0)
  availability_zone      = element(module.vpc.azs, 0)

  tags = {
    Environment = "dev"
    Name        = "Demo-Sample-1"
  }
}
#IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id
}
#Route Table
resource "aws_route_table" "rtb" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
#Creating ALB
resource "aws_lb" "test" {
  name               = "test-lb-tf1"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.web_server_sg.security_group_id]
  subnets            = [module.vpc.private_subnets[0], module.vpc.public_subnets[1]]

  enable_deletion_protection = false

  tags = {
    Environment = "dev"
  }
}
#Target Group
resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}
#Target Group Attachment to Instance
resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.ec2-demo.id
  port             = 80
}
