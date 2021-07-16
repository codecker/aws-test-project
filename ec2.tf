# EC2 to host NGINX web server

# Get latest AmazonLinux2 instance details 
data "aws_ami" "latest_amzlinux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "test_nginx" {
  ami                    = data.aws_ami.latest_amzlinux2.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.nginx_public_sg.id]
  key_name               = var.ec2-key_name

  # TODO: Finish EC2 deployment

  # connection {
  #   type = 
  # }
}
