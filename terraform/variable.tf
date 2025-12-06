variable "studentapp_instance_type" {
  default = "t3.micro"
}
variable "studentapp_ami" {
  default = "ami-02b8269d5e85954ef"
}
variable "studentapp_key_name" {
  default = "Oct30"
}
variable "studentapp_vpc_security_group_ids" {
  default = "sg-0a1badee4156834ca"
}
variable "studentapp_disable_api_termination" {
  default = "false"
}
