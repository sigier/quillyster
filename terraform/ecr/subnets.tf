resource "aws_subnet" "public" {
  count             = 2
  vpc_id           = aws_vpc.main.id
  cidr_block       = element(["10.0.0.0/24", "10.0.1.0/24"], count.index)
  map_public_ip_on_launch = true
  availability_zone = element(["eu-central-1a", "eu-central-1b"], count.index)

    tags = {
    Name        = "Public-Subnet-Nextio${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count             = 2
  vpc_id           = aws_vpc.main.id
  cidr_block       = element(["10.0.2.0/25", "10.0.3.0/25"], count.index)
  availability_zone = element(["eu-central-1a", "eu-central-1b"], count.index)

    tags = {
    Name        = "Private-Subnet-Nextio${count.index + 1}"
  }
}
