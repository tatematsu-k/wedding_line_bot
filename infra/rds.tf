data "aws_secretsmanager_secret" "rds_password" {
  name = "wedding-line-bot-rds-password"
}

data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id = data.aws_secretsmanager_secret.rds_password.id
}

module "rds_security_group" {
  source = "terraform-aws-modules/security-group/aws"
  version = "4.8.0"

  name        = "wedding-line-bot-rds_security_group"
  description = "Security group for RDS of wedding-line-bot."
  vpc_id      = module.vpc.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = module.ecs_security_group.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  egress_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  egress_rules       = ["all-all"]
}

resource "aws_db_subnet_group" "wedding-line-bot" {
  name       = "wedding-line-bot"
  subnet_ids = module.vpc.private_subnets
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "wedding-line-bot"
  engine_mode             = "serverless"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.07.1"

  db_subnet_group_name    = aws_db_subnet_group.wedding-line-bot.name
  availability_zones      = module.vpc.azs

  master_username         = "root"
  master_password         = data.aws_secretsmanager_secret_version.rds_password.secret_string

  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true

  vpc_security_group_ids = [module.rds_security_group.security_group_id]

  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.default.id
}

resource "aws_rds_cluster_parameter_group" "default" {
  name        = "rds-cluster-pg"
  family      = "aurora-mysql5.7"
  description = "RDS default cluster parameter group"

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}
