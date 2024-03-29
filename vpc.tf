#VPC Creation

resource "aws_vpc" "myvpc" {
  cidr_block = "100.100.0.0/20"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
    tags = {
	Name = "MV-IGW"
	}
}

resource "aws_subnet" "public_subnet_01" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "100.100.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
    tags = {
	Name = "MV-Public-Sub-01"
	}
}

resource "aws_subnet" "private_subnet_01" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "100.100.6.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false
    tags = {
	Name = "MV-Private-Sub-01"
	}
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id
  route{
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }
    tags = {
	Name = "MV-Public-RT"
	}
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.myvpc.id
    tags = {
	Name = "MV-Private-RT"
	}
}
resource "aws_route_table_association" "public_association" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id = aws_subnet.public_subnet_01.id
}

resource "aws_route_table_association" "private_association" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id = aws_subnet.private_subnet_01.id
}

