resource "aws_security_group" "aec_sg_teamcity" {
  name = "agile_engineering_class_teamcity"
  description = "Agile Engineering Class - TeamCity SMTP and SSH Access"
  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  ingress {
    protocol = "tcp"
    from_port = 25
    to_port = 25
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    Name = "Agile Engineering Class TeamCity"
  }
}