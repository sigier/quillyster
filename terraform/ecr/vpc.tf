resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/22" #1024 IPs
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "MainVPCNextio"
  }
}