# ─────────────────────────────────────────────────────────────────────────────
# AWS Playground — simplest possible setup to learn Terraform + AWS
#
# What gets created:
#   VPC → Internet Gateway → Public Subnet → Route Table
#   Security Group (SSH + HTTP)
#   EC2 t2.micro (free tier)
#
# Cost: $0 on AWS free tier (12 months)
# ─────────────────────────────────────────────────────────────────────────────

# ─── Latest Amazon Linux 2023 AMI ────────────────────────────────────────────
# This always fetches the most recent AMI so you never hardcode an AMI ID

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# ─── VPC ──────────────────────────────────────────────────────────────────────

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = "playground-vpc" }
}

# ─── Internet Gateway ─────────────────────────────────────────────────────────
# Connects the VPC to the internet

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = { Name = "playground-igw" }
}

# ─── Public Subnet ────────────────────────────────────────────────────────────
# EC2 will live here and get a public IP automatically

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = { Name = "playground-public-subnet" }
}

# ─── Route Table ──────────────────────────────────────────────────────────────
# Sends all outbound traffic (0.0.0.0/0) to the Internet Gateway

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = { Name = "playground-rt" }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# ─── Security Group ───────────────────────────────────────────────────────────
# Controls what traffic can reach the EC2 instance

resource "aws_security_group" "ec2" {
  name        = "playground-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.main.id

  # SSH — lets you connect from your laptop
  ingress {
    description = "SSH from your machine"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # HTTP — lets you test a web server if you install one
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # All outbound traffic allowed (so the instance can install packages etc.)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "playground-sg" }
}

# ─── EC2 Instance ─────────────────────────────────────────────────────────────
# t2.micro = free tier eligible (750 hours/month for 12 months)

resource "aws_instance" "playground" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name               = var.key_pair_name

  tags = { Name = "playground-ec2" }
}
