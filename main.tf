

#code to create variable, we can use this variable to call the keypair block 
#variable block for keyname
variable "key-name" {
    description = "keypair name to be created"
    type = string  # a string is anything with double code
    default = "utc-key"  #this means if somebody does not provide the name use this
}

  # variable block for filename
  variable "file_name" {
    default = "utc-key.pem"   # we most not put the default here if we dont want , when doing terraform apply it will ask us to enter the name we want
  }



#code to create keypair
 resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
#Create the Key Pair
resource "aws_key_pair" "aws_key" {
  key_name   = var.key-name  # recalling it from variable
  public_key = tls_private_key.ec2_key.public_key_openssh
}
# Save file
resource "local_file" "ssh_key" {                                      # tthis is all a about module. module is a great tool to help a colleague to call ur code and use
  filename = var.file_name                                              # it an create it own resouce block
  content  = tls_private_key.ec2_key.private_key_pem
}

# output for keypair
output "key_name" {
  value = aws_key_pair.aws_key.key_name
}
output "pem_file" {
  value = local_file.ssh_key.filename
}

# the above is a module but the question now is how can somebody who does not have acces to keypair  call this my key code above and use it
