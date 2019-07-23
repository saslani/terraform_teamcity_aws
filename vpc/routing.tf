resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "TeamCity Gateway"
  }
}

resource "aws_route_table" "vpc_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = {
    Name = "TeamCity Public Subnet Route Table"
  }
}

resource "aws_route_table_association" "vpc_public" {
  subnet_id      = aws_subnet.public[0].id
  route_table_id = aws_route_table.vpc_public.id
}

resource "aws_route_table" "vpc_private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.gw.id
  }

  tags = {
    Name = "TeamCity Private Subnet's Route Table"
  }
}

resource "aws_route_table_association" "vpc_private" {
  count          = var.length
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.vpc_private.id
}

