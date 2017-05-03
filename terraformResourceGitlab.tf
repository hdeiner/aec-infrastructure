resource "aws_instance" "ec2_aec_gitlab" {
  ami = "ami-80861296"
  instance_type = "m4.large"
  key_name = "aws_linux"
  security_groups = ["${aws_security_group.aec_sg_gitlab.name}"]
  provisioner "remote-exec" {
    connection {
      type = "ssh",
      user = "ubuntu",
      private_key = "${file("~/.ssh/aws_linux.pem")}"
    }
    script = "provisionGitLab.sh"
  }
  tags {
    Name = "Agile Engineering Class GitLab"
  }
}