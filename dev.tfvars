  region = "eu-west-2"

  db_tags = {
    Name = "caci_Test_Db_Instance"
  }
  vpc_tags = {
    Name = "CACI_Test_Vpc"
  }
  db_subnet_tags = {
    Name = "CACI_DB_Subnet"
  }

  app_subnet_tags = {
    Name = "CACI_App_Subnet"
  }
  database_name = "mysqldb1"
  identifier           = "caci-test-rds-instance"
  cluster_identifier   = "caci-test-aurora-cluster"
  allocated_storage    = 100  
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.medium" 
  username             = "db_user"
  db_password             = "Rds2023abc"
 