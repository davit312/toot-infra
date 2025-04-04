resource "aws_route_table" "rt-private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "rt-private"
  }
}

resource "aws_route_table_association" "add-private-rt" {
  count          = 2
  subnet_id      = aws_subnet.private-subnets[count.index].id
  route_table_id = aws_route_table.rt-private.id
}

/** **/

resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt-public"
  }
}

resource "aws_route_table_association" "add-public-rt" {
  count          = 2
  subnet_id      = aws_subnet.public-subnets[count.index].id
  route_table_id = aws_route_table.rt-public.id
}

