resource "aws_vpc" "project_vpc" {
  cidr_block = "12.0.0.0/16"
  enable_dns_hostnames = true
  tags={
    Name="project-vpc"
  }
}