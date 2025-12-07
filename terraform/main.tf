resource "aws_instance" "studentapp" {
  instance_type           = var.studentapp_instance_type
  ami                     = var.studentapp_ami
  key_name                = var.studentapp_key_name
  vpc_security_group_ids  = [var.studentapp_vpc_security_group_ids]
  disable_api_termination = var.studentapp_disable_api_termination
  user_data               = <<-EOT
    #!/bin/bash
     sudo apt update -y
     sudo apt install mysql-client -y

     git clone https://github.com/DIVATEe/studentapp.git
     cd studentapp/

     chmod 700 dockerinstall.sh
     sh dockerinstall.sh

     docker compose up -d
     
     mysql -h ${aws_db_instance.studentapp_db.address} -u admin -p${var.studentapp_db_password}

     create database  studentapp;
     use studentapp;
      CREATE TABLE if not exists students(student_id INT NOT NULL AUTO_INCREMENT,  
	    student_name VARCHAR(100) NOT NULL,  
	    student_addr VARCHAR(100) NOT NULL,   
	    student_age VARCHAR(3) NOT NULL,      
	    student_qual VARCHAR(20) NOT NULL,     
	    student_percent VARCHAR(10) NOT NULL,   
	    student_year_passed VARCHAR(10) NOT NULL,  
	    PRIMARY KEY (student_id)  
      );
      show tables;
      exit
      
     EOT
}

resource "aws_db_instance" "studentapp_db" {
  identifier = "studentapp"
  db_name = var.studentapp_db_db_name
  username = var.studentapp_db_username
  password = var.studentapp_db_password
  instance_class = var.studentapp_db_instance_class
  allocated_storage = var.studentapp_db_allocated_storage
  engine = "MariaDB"
  engine_version = "11.4.8"
  skip_final_snapshot = true
}




output "studentapp_publicip" {
  value = aws_instance.studentapp.public_ip
}