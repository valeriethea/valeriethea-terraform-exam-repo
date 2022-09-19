module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 3.0"

  identifier = "demodb"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.micro"
  allocated_storage = 5

  name     = "demodb"
  username = var.db_username
  password = var.db_password
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [module.web_server_sg.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  tags = {
    Environment = "dev"
  }

  # DB subnet group
  subnet_ids = module.vpc.database_subnets 
    
  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Database Deletion Protection
  deletion_protection = true #false

  # Disable creation of option group - provide an option group or default AWS default
  create_db_option_group = false
  
  #RECENTLY ADDED = SEP 19, 2022
  # Disable creation of RDS instance
  create_db_instance = false
    
  #Disable creation of option group
  create_db_option_group = false
    
  #Disable creation of parameter group
  create_db_parameter_group = false
    
  #Disable creation of subnet group
  create_db_subnet_group = false

  #Disable creation database
  create_db = true
  -----
  
  #Disable Final Snapshot 
  skip_final_snapshot = false

  #Parameters character set for client
  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]
}
