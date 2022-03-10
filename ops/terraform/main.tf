provider "aws" {
  region = "eu-west-1"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "gpenaud"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDLLNYwcvkVf6Zol/gE03XtMKc31gaALFzXeMyZXWfT1MAqgmpPF/lZWMjpzvA5X2xwDknSOQIOw27N8wKXlp9bBY6N2Nw5EbVOzW8eWKU/lCq0FkoE36yiBR+8ISV6eqc0BAJtYrv8AiujbGRApzf7kBGCXrDcdY4GKxiy1gqLBnnRxk+q9ystZBaC14YNnhaIzt1YhcVKPnj/BV+RUkL5Mmf5nlcqNKuOKmh0TZwJdjITwF6aRugKdajr03ZXL0MbaHG3bM8/DRoCLFXr53jPCuvAydNcLsaTvs6NjaXfUJJnKZ4L3vBHsmLB9vDXfA/mw8GYlnSn5O1PrLkZ1wbZOzcnFGZAUju8poY96WIVcQzc08Ne3zSxYlh0wAepy/8lhoV7ubkn2EhiWmawa5DYNQS/GJymFlYT0dGzOL6uyljB5KeFJm4J3zXl7secELVmezII6N9iBuz1B/vjCRYByAoV9PbGw6yn7g2Lt6byCjUmQk9MCR1dhly0uFJ14tgp6UX2TLn5o9eCj7MfQBVvOSV0fyyb1ijigJGRO1NIF3Ddz2fPzygt3aU4K3XRwEKaT4T9rau0ltGu7/LEpiS/8NT88lGMK3FeSyB0fq/6p25B58FrRzQf2vFk8l+dp1DfXl2C0k83c3gNE2BLtcW0puLF6pvNIwlTMV35k9xTVw== gpenaud@personal"

  tags = {
    name  = "docker-server-for-cagette"
    owner = "Guillaume Penaud"
  }
}

resource "aws_security_group" "security_groups" {
  name        = "cagette-sg"
  description = "security group for cagette"

  dynamic "ingress" {
    for_each = ["22", "80", "443"]
    content {
      description = "allow ssh / http / https ports on ingress"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "allow all ports on egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name  = "docker-server-for-cagette"
    owner = "Guillaume Penaud"
  }
}

resource "aws_instance" "instance" {
  ami           = "ami-08ca3fed11864d6bb"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.ssh_key.id
  security_groups = [
    aws_security_group.security_groups.name
  ]

  tags = {
    name  = "docker-server-for-cagette"
    owner = "Guillaume Penaud"
  }
}

output "instance_ip" {
  value = aws_instance.instance.public_ip
}
