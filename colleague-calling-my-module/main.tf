provider "aws" {
  region = "us-east-1"
}

# this colleague want to use my keypair code

  module "keypair" {
    source = "../modules"
    key-name = "collegue"
    file-name = "collegue.pem"
  }
                                # creating key by recalling
    module "keypair2" {
    source = "../modules"
    key-name = "collegue1"
    file-name = "collegue1.pem"
  }


     # this module was copy from terraform registry i am only callin and modifying it just like the keypair above 
     # the only diffn is the keypair was call locally while the vpc was call from online
  module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "devops-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a",  "us-east-1b"]
  private_subnets = ["10.0.1.0/24",  "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24",  "10.0.103.0/24"]

  enable_nat_gateway = true # u can still put false
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}