
provider "aws" {
  region = "eu-west-2" 
}

resource "aws_db_instance" "caci_test_rds" {
  identifier           = var.identifier
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = "mysql"
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot = true

  vpc_security_group_ids = [aws_security_group.allow_mysql.id] 
  db_subnet_group_name      = aws_db_subnet_group.db_subnet_group.name  
  multi_az              = true
  publicly_accessible  = false
  performance_insights_enabled = true
  performance_insights_retention_period = 7

  # to enable backups uncommnent below
  # backup_retention_period = 7
  # backup_window           = "03:00-04:00"

  # to enable maintenance window uncommnent below
  # preferred_maintenance_window = "sun:05:00-sun:06:00"
 
  tags = var.db_tags
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [aws_subnet.db_subnet.id,aws_subnet.app_subnet.id]
  

  tags = var.db_tags
}

resource "aws_vpc" "test_vpc" {
  
  cidr_block = "10.0.0.0/16"

  tags = var.vpc_tags

}

resource "aws_subnet" "db_subnet" { 
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-west-2a"
  tags = var.db_subnet_tags

}

resource "aws_subnet" "app_subnet" { 
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-2b"

  tags = var.app_subnet_tags
}

resource "aws_security_group" "allow_mysql" {
  name        = "allow_mysql"
  description = "Allow mysql inbound traffic"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    description      = "allow mysql from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.test_vpc.cidr_block]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "allow_db"
  }
}

#  Amazon Aurora terraform code
# resource "aws_rds_cluster" "aurora_cluster" {
#   cluster_identifier      = var.cluster_identifier
#   engine                  = "aurora-mysql"
#   engine_version          = "5.7.mysql_aurora.2.11.3"
#   master_username         = var.username
#   master_password         = var.db_password
#   database_name           = var.database_name
#   port                    = 3306
#   backup_retention_period = 7
#   # preferred_backup_window = "03:00-04:00"

#   vpc_security_group_ids  = [aws_security_group.allow_mysql.id] 
#   db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
#   availability_zones = ["eu-west-2a","eu-west-2b"]
#   skip_final_snapshot = true
# }

# resource "aws_rds_cluster_instance" "aurora_instance" {
#   count                = 2
#   identifier           = "aurora-instance-${count.index}"
#   cluster_identifier   = aws_rds_cluster.aurora_cluster.id
#   instance_class       = "db.r5.large"  
#   engine = "aurora-mysql"
# }

# resource "aws_security_group" "aurora_security_group" {
#   name        = "aurora-db-sg"
#   description = "Security group for Aurora DB"

#   ingress {
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = ["10.0.0.0/16"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_security_group_rule" "aurora_ingress_rule" {
#   security_group_id = aws_security_group.aurora_security_group.id
#   type              = "ingress"
#   from_port         = 3306
#   to_port           = 3306
#   protocol          = "tcp"
#   source_security_group_id = aws_security_group.aurora_security_group.id
# }
