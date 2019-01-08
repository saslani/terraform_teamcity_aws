resource "aws_eip" "nat_gw_eip" {
  vpc = true

  tags {
    Name = "TeamCity NAT"
  }
}

resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat_gw_eip.id}"
  subnet_id     = "${aws_subnet.public.id}"

  tags {
    Name = "TeamCity NAT Gateway"
  }
}
