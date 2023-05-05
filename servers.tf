data "aws_ami" "centos" {
  owners      = ["973714476881"]
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
}

data "aws_security_group" "allow-all" {
  name = "allow-all"
}

#variable "instance_type" {
#  default = "t3.small"
#}

#variable "components" {
 # default = ["frontend", "mongodb", "redis"]
#}

variable "components" {
  default = {
    frontend = {
      name = "frontend"
      instance_type = "t3.small"
    }
    mongodb = {
      name = "mongodb"
      instance_type = "t3.small"
    }
    redis = {
      name = "redis"
      instance_type = "t3.small"
    }
  }
}
resource "aws_instance" "instance" {
  for_each         = var.components
  ami              = data.aws_ami.centos.image_id
  instance_type    = each.value["instance_type"]
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id]

  tags = {
    Name = each.value["name"]
  }
}

resource "aws_route53_record" "records" {
  for_each = var.components
  zone_id = "Z086778943HEZIHKI7U9"
  name    = "${each.value["name"]}.gehana26.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance[each.value["name"]].private_ip]
}

#resource "aws_instance" "mongodb" {
#  ami              = data.aws_ami.centos.image_id
#  instance_type    = "t3.micro"
#
#  tags = {
#    Name = "mongodb"
#  }
#}
#
#resource "aws_instance" "catalogue" {
#  ami              = data.aws_ami.centos.image_id
#  instance_type    = "t3.micro"
#
#  tags = {
#    Name = "catalogue"
#  }
#}
#
#resource "aws_instance" "redis" {
#  ami              = data.aws_ami.centos.image_id
#  instance_type    = "t3.micro"
#
#  tags = {
#    Name = "redis"
#  }
#}
#
#resource "aws_instance" "user" {
#  ami              = data.aws_ami.centos.image_id
#  instance_type    = "t3.micro"
#
#  tags = {
#    Name = "user"
#  }
#}
#
#resource "aws_instance" "cart" {
#  ami              = data.aws_ami.centos.image_id
#  instance_type    = "t3.micro"
#
#  tags = {
#    Name = "cart"
#  }
#}
#
#resource "aws_instance" "mysql" {
#  ami              = data.aws_ami.centos.image_id
#  instance_type    = "t3.micro"
#
#  tags = {
#    Name = "mysql"
#  }
#}
#
#resource "aws_instance" "shipping" {
#  ami              = data.aws_ami.centos.image_id
#  instance_type    = "t3.micro"
#
#  tags = {
#    Name = "shipping"
#  }
#}
#
#resource "aws_instance" "rabbitmq" {
#  ami              = data.aws_ami.centos.image_id
#  instance_type    = "t3.micro"
#
#  tags = {
#    Name = "rabbitmq"
#  }
#}
#
#resource "aws_instance" "payment" {
#  ami              = data.aws_ami.centos.image_id
#  instance_type    = "t3.micro"
#
#  tags = {
#    Name = "payment"
#  }
#}