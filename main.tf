provider "aws" {
  region     = "us-east-1"
}

resource "aws_security_group" "aec_sg_student" {
  name = "agile_engineering_class_student"
  description = "Agile Engineering Class - Guacamole and SSH Access"
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
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
    Name = "Agile Engineering Class Student"
  }
}

resource "aws_security_group" "aec_sg_jenkins" {
  name = "agile_engineering_class_jenkins"
  description = "Agile Engineering Class - Jenkins SMTP and SSH Access"
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 25
    to_port     = 25
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
    Name = "Agile Engineering Class Jenkins"
  }
}

resource "aws_instance" "ec2_aec_student" {
  count           = 1
  ami             = "ami-80861296"
  instance_type   = "m4.large"
  key_name        = "aws_linux"
  security_groups = [ "${aws_security_group.aec_sg_student.name}" ]
  provisioner "remote-exec" {
    connection {
      type        = "ssh",
      user        = "ubuntu",
      private_key = "${file("~/.ssh/aws_linux.pem")}"
    }
    script = "provisionGuacamole.sh"
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
    Name = "Agile Engineering Class Student Instance ${format("%03d", count.index)}"
  }
}

resource "aws_instance" "ec2_aec_jenkins" {
  ami             = "ami-80861296"
  instance_type   = "t2.micro"
  key_name        = "aws_linux"
  security_groups = [ "${aws_security_group.aec_sg_jenkins.name}" ]
  provisioner "remote-exec" {
    connection {
      type        = "ssh",
      user        = "ubuntu",
      private_key = "${file("~/.ssh/aws_linux.pem")}"
    }
    script = "provisionJenkins.sh"
  }
  tags {
    Name = "Agile Engineering Class Jenkins Instance"
  }
}

output "student_addresses" {
  value = ["${aws_instance.ec2_aec_student.*.public_dns}"]
}
output "jenkins_address" {
  value = ["${aws_instance.ec2_aec_jenkins.*.public_dns}"]
}
