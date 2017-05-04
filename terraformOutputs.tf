output "student_addresses" {
  value = ["${aws_instance.ec2_aec_student.*.public_dns}"]
}

output "teamcity_address" {
  value = ["${aws_instance.ec2_aec_teamcity.*.public_dns}"]
}

output "jenkins_address" {
  value = ["${aws_instance.ec2_aec_jenkins.*.public_dns}"]
}

output "gitlab_address" {
  value = ["${aws_instance.ec2_aec_gitlab.*.public_dns}"]
}