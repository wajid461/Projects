provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
}

module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source = "./modules/route_table"
  vpc_id = module.vpc.vpc_id
  my_igw = module.internet_gateway.igw_id
  public_subnet = module.subnet.public_subnet_id
}

module "jump_security_group" {
  source = "./modules/security_group/jump_security_group"
  vpc_id = module.vpc.vpc_id
}

module "webserver_security_group" {
  source = "./modules/security_group/webserver_security_group"
  vpc_id = module.vpc.vpc_id
}

module "jenkins_security_group" {
  source = "./modules/security_group/jenkins_security_group"
  vpc_id = module.vpc.vpc_id
}

module "jump_instance" {
  source = "./modules/ec2_instance/jump"
  jump_security_group = module.jump_security_group.jump_security_group_id
  subnet_id = module.subnet.public_subnet_id
}

module "webserver_instance" {
  source = "./modules/ec2_instance/webserver"
  webserver_security_group = module.webserver_security_group.webserver_security_group_id
  subnet_id = module.subnet.public_subnet_id
}

module "jenkins_instance" {
  source = "./modules/ec2_instance/jenkins"
  jenkins_security_group = module.jenkins_security_group.jenkins_security_group_id
  subnet_id = module.subnet.public_subnet_id
}