resource "aws_instance" "studentapp" {
  instance_type = var.studentapp_instance_type
  ami = var.studentapp_ami
  key_name = var.studentapp_key_name
  vpc_security_group_ids = [ var.studentapp_vpc_security_group_ids ]
  disable_api_termination = var.studentapp_disable_api_termination
}