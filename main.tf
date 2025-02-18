resource "aws_instance" "public_instance" {
 ami           = var.ami
 instance_type = var.instance_type
 subnet_id     = "subnet-0d8c52cc1bea2e510"

 tags = {
   Name = var.name_tag,
 }
}
