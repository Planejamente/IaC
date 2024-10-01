terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
}

provider "aws" {
    region = "sa-east-1"
    profile = "default"
}

# vpc simple

resource "aws_vpc" "simple_vpc" {
  cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "simple_vpc"
    }
}
resource "aws_subnet" "some_public_subnet" {
  vpc_id            = aws_vpc.simple_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "Some Public Subnet"
  }
}

resource "aws_subnet" "some_private_subnet" {
  vpc_id            = aws_vpc.simple_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "Some Private Subnet"
  }
}


resource "aws_internet_gateway" "some_ig" {
  vpc_id = aws_vpc.simple_vpc.id

  tags = {
    Name = "Some Internet Gateway"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.simple_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.some_ig.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.some_ig.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_1_rt_a" {
  subnet_id      = aws_subnet.some_public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_security_group" "web_sg" {
  name   = "HTTP and SSH"
  vpc_id = aws_vpc.simple_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "web_instance" {
  ami           = "ami-0cd690123f92f5079"
  instance_type = "t2.micro"
  key_name      = "planejamente"

  subnet_id                   = aws_subnet.some_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true



  tags = {
    "Name" : "Kanye"
  }
  user_data = <<-EOF
              #!/bin/bash
              # Atualizar pacotes e instalar Docker
              sudo yum update -y
              sudo amazon-linux-extras install docker
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -a -G docker ec2-user

              # Instalar Docker Compose
              sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
              sudo chmod +x /usr/local/bin/docker-compose

              # Criar arquivo docker-compose.yml
              cat <<EOL > docker-compose.yml
              services:
                caddy:
                  image: caddy:latest
                  ports:
                    - "80:80"
                    - "443:443"
                  volumes:
                    - ./Caddyfile:/etc/caddy/Caddyfile
                    - caddy_data:/data
                    - caddy_config:/config
                webserver:
                  image: pjmocker/webapp:latest
                  ports:
                    - "8080:80"
              volumes:
                caddy_data:
                caddy_config:
              EOL

              # Criar arquivo Caddyfile
              cat <<EOL > Caddyfile
              planejamente.tech {
                reverse_proxy webserver:80
              }
              EOL

              # Iniciar os serviços com Docker Compose
              sudo /usr/local/bin/docker-compose -p web up -d
              EOF
}

output "public_ip" {
  value = aws_instance.web_instance.public_ip
}

