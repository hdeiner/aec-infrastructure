output "aws_key_pair" {
  value = ["${aws_key_pair.aec_key_pair.key_name}"]
}

output "student_addresses" {
  value = ["${aws_instance.ec2_aec_student.*.public_dns}"]
}

output "student_ips" {
  value = ["${aws_instance.ec2_aec_student.*.public_ip}"]
}

output "teamcity_address" {
  value = ["${aws_instance.ec2_aec_teamcity.*.public_dns}"]
}

output "teamcity_ip" {
  value = ["${aws_instance.ec2_aec_teamcity.*.public_ip}"]
}

output "jenkins_address" {
  value = ["${aws_instance.ec2_aec_jenkins.*.public_dns}"]
}

output "jenkins_ip" {
  value = ["${aws_instance.ec2_aec_jenkins.*.public_ip}"]
}

output "gitlab_address" {
  value = ["${aws_instance.ec2_aec_gitlab.*.public_dns}"]
}

output "gitlab_ip" {
  value = ["${aws_instance.ec2_aec_gitlab.*.public_ip}"]
}