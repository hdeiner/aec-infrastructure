resource "aws_instance" "ec2_aec_student" {
  count = 1
  ami = "ami-f38abe89"
  instance_type = "m4.large"
  key_name = "${aws_key_pair.aec_key_pair.key_name}"
  security_groups = [
    "${aws_security_group.aec_sg_student.name}"]
  tags {
    Name = "Agile Engineering Class Student ${format("%03d", count.index)}"
  }
}