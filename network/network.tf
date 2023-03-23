# Create a new VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create an internet gateway and attach it to the VPC
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# Create two public subnets, one in each availability zone, and associate them with the VPC
resource "aws_subnet" "public_subnet_az1" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_az2" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true
}

# Create two private subnets in each availability zone, and associate them with the VPC
resource "aws_subnet" "private_subnet_az1a" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_subnet" "private_subnet_az1b" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_subnet" "private_subnet_az2a" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-west-2b"
}

resource "aws_subnet" "private_subnet_az2b" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-west-2b"
}

# Create a NAT gateway in each public subnet
resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = aws_eip.nat_gateway_az1.id
  subnet_id = aws_subnet.public_subnet_az1.id
}

resource "aws_nat_gateway" "nat_gateway_az2" {
  allocation_id = aws_eip.nat_gateway_az2.id
  subnet_id = aws_subnet.public_subnet_az2.id
}

# Create an elastic IP for each NAT gateway
resource "aws_eip" "nat_gateway_az1" {
  vpc = true
}

resource "aws_eip" "nat_gateway_az2" {
  vpc = true
}

# Create a route table for the public subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  # Route traffic to the internet gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Create a route table for the private subnets
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc
