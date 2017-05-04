resource "aws_instance" "ec2_aec_teamcity" {
  ami = "ami-80861296"
  instance_type = "m4.large"
  key_name = "aws_linux"
  security_groups = ["${aws_security_group.aec_sg_teamcity.name}"]
  provisioner "remote-exec" {
    connection {
      type = "ssh",
      user = "ubuntu",
      private_key = "${file("~/.ssh/aws_linux.pem")}"
    }
    script = "provisionTeamCity.sh"
  }
  tags {
    Name = "Agile Engineering Class TeamCity"
  }
}