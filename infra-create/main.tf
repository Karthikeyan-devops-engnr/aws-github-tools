resource "aws_instance" "tool" {
  ami                    = data.aws_ami.rhel9.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.tool-sg.id]
  iam_instance_profile   = aws_iam_instance_profile.instance-profile.name
  subnet_id = "subnet-03beed56c0c97fe72"
  tags = {
    Name = var.name
  }
}

resource "aws_security_group" "tool-sg" {
  name        = "${var.name}-sg"
  description = "${var.name}-sg"
  vpc_id      =  data.aws_vpc.existing.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-sg"
  }
}

resource "aws_route53_record" "record-public" {
  zone_id = var.hosted_zone_id
  name    = var.name
  type    = "A"
  ttl     = 10
  records = [aws_instance.tool.public_ip]
}

resource "aws_route53_record" "record-private" {
  zone_id = var.hosted_zone_id
  name    = "${var.name}-internal"
  type    = "A"
  ttl     = 10
  records = [aws_instance.tool.private_ip]
}

