provider "aws" {
  region     = "us-east-1"
}

resource "aws_security_group" "aec_sg" {
  name = "agile_engineering_class"
  description = "Agile Engineering Class - Guacamole and SSH Access"
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags {
    Name = "Agile Engineering Class"
  }
}

resource "aws_instance" "ec2_aec" {
  count           = 1
  ami             = "ami-80861296"
  instance_type   = "m4.large"
  key_name        = "aws_linux"
  security_groups = [ "${aws_security_group.aec_sg.name}" ]
  provisioner "remote-exec" {
    connection {
      type        = "ssh",
      user        = "ubuntu",
      private_key = "${file("~/.ssh/aws_linux.pem")}"
    }
    script = "provision.sh"
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh",
      user        = "ubuntu",
      private_key = "${file("~/.ssh/aws_linux.pem")}"
    }
    inline = [
      "sudo reboot now"
    ]
  }
  tags {
    Name = "Agile Engineering Class EC2 Instance ${format("%03d", count.index)}"
  }
}

output "addresses" {
  value = ["${aws_instance.ec2_aec.*.public_dns}"]
}
