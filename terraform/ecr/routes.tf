resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "PublicRouteTableNextio"
  }
}

resource "aws_route_table_association" "public" {
  count = 2

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private" {
  for_each = {
    1 = aws_nat_gateway.nat_1.id
    2 = aws_nat_gateway.nat_2.id
  }

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = each.value
  }

  tags = {
    Name = "PrivateRouteTable-${each.key}"
  }
}

resource "aws_route_table_association" "private" {
  for_each = {
    1 = aws_subnet.private[0].id
    2 = aws_subnet.private[1].id
  }

  subnet_id      = each.value
  route_table_id = aws_route_table.private[each.key].id
}
