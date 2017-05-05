resource "aws_key_pair" "aec_key_pair" {
  key_name = "aec_key_pair"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}