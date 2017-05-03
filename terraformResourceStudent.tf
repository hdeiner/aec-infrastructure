resource "aws_instance" "ec2_aec_student" {
  count = 1
  ami = "ami-80861296"
  instance_type = "m4.large"
  key_name = "aws_linux"
  security_groups = ["${aws_security_group.aec_sg_student.name}"]
  provisioner "remote-exec" {
    connection {
      type = "ssh",
      user = "ubuntu",
      private_key = "${file("~/.ssh/aws_linux.pem")}"
    }
    script = "provisionGuacamole.sh"
  }
  provisioner "remote-exec" {
    connection {
      type = "ssh",
      user = "ubuntu",
      private_key = "${file("~/.ssh/aws_linux.pem")}"
    }
    inline = ["sudo reboot now"]
  }
  tags {
    Name = "Agile Engineering Class Student ${format("%03d", count.index)}"
  }
}