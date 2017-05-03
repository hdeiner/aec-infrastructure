resource "aws_instance" "ec2_aec_jenkins" {
  ami = "ami-80861296"
  instance_type = "t2.micro"
  key_name = "aws_linux"
  security_groups = ["${aws_security_group.aec_sg_jenkins.name}"]
  provisioner "remote-exec" {
    connection {
      type = "ssh",
      user = "ubuntu",
      private_key = "${file("~/.ssh/aws_linux.pem")}"
    }
    script = "provisionJenkins.sh"
  }
  tags {
    Name = "Agile Engineering Class Jenkins"
  }
}