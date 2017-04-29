# SolutionsIQ Agile Engineering Course Infrastructure Using Terraform 

This is a fairly simple Terraform example that can generate as many EC2 instances as necessary for the SolutionsIQ Agile Engineering Course. Some requirements that lead to this solution are:

  - Need for a development environment with appropriate tools (IDE, etc.)
  - Need to have zero installation on client machines (no software, no open ports, etc.)  Must run in browser.
  - Low cost.
  - Easy to setup before class starts.
  - Provide a continuous integration machine for class demos.

# Design 
To meet these goals, the decision was made to run on AWS EC2 instances.  These instances are treated as Infrastructure as Code (hence this project).  As written, the instances run Ubuntu 16.04.  There is not a publically available AWS AMI that includes the Ubuntu Desktop.  This project provisions a complete desktop, along with IntelliJ for students to easily write and debug code with.

To gain access to the desktop, virutal network computing (VNC) protocol is layered on top of the X11 desktop.  To provide a solution that is purely web based, Apache Guacamole is then layered on top of that to render the VNC into HTML5.  This also provides the ability to have several students share desktops, for classroom aid, as well as remote pairing.  Students merely have to point their browser to http://[AWS EC2 Public DNS Name]:8080/guacamole.  Use USERNAME and PASSWORD for access.

# Use
1. Make sure that you can use AWS CLI without issue.  In particular,
you need valid ~/.aws config and credentials files.
2. Create and downoad ssh PEM files.  This project referes to ~/.ssh/aws_linux.pem
in several places.  Update accordingly.
3. Make sure that Terraform is installed.
4. Ensure that main.tf has appropriate settings for your use.  For example,
the AWS region may have to change, and that will require a change in the 
AMI used.
5. On the command line, create the infrastructure with
 ```
 terraform apply
 ```
6. You should see things such as 
```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: 

Outputs:

jenkins_address = [
    ec2-34-203-188-4.compute-1.amazonaws.com
]
student_addresses = [
    ec2-54-164-91-148.compute-1.amazonaws.com
]
```
7. Transfer all output addressess into infrastructure.feature for 
testing, as well as for informing students of what their machine's
URL will be.  On the command line, test the infrastrusture with 
```
mvn test
```
8. Students log on to their machine at port 8080 and a guacamole uri.
For example, a student would point their browser to
```
http://ec2-54-152-234-84.compute-1.amazonaws.com:8080/guacamole
```
9. Log on with USERNAME and PASSWORD.
10. It is assumed that you know how to use and configure Jenkins.  Point your browser to the URL:8080 created and provisioned by Terraform.  You will have to ssh into the Jenkins server once to supply the secret password to the browser.
11. When the infrastructure is no longer needed, destroy the 
infrastructure on the command line with
```
terraform destroy
```
12. You will have to type in "yes" and should see things like:
```
Do you really want to destroy?
  Terraform will delete all your managed infrastructure.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_security_group.aec_sg_jenkins: Refreshing state... (ID: sg-15e70d6b)
aws_security_group.aec_sg_student: Refreshing state... (ID: sg-03fb117d)
aws_instance.ec2_aec_student: Refreshing state... (ID: i-00d626d0324de0037)
aws_instance.ec2_aec_jenkins: Refreshing state... (ID: i-0bd3159a4218f6e7a)
aws_instance.ec2_aec_student: Destroying... (ID: i-00d626d0324de0037)
aws_instance.ec2_aec_jenkins: Destroying... (ID: i-0bd3159a4218f6e7a)
aws_instance.ec2_aec_jenkins: Still destroying... (ID: i-0bd3159a4218f6e7a, 10s elapsed)
aws_instance.ec2_aec_student: Still destroying... (ID: i-00d626d0324de0037, 10s elapsed)
aws_instance.ec2_aec_jenkins: Still destroying... (ID: i-0bd3159a4218f6e7a, 20s elapsed)
aws_instance.ec2_aec_student: Still destroying... (ID: i-00d626d0324de0037, 20s elapsed)
aws_instance.ec2_aec_jenkins: Still destroying... (ID: i-0bd3159a4218f6e7a, 30s elapsed)
aws_instance.ec2_aec_student: Still destroying... (ID: i-00d626d0324de0037, 30s elapsed)
aws_instance.ec2_aec_student: Still destroying... (ID: i-00d626d0324de0037, 40s elapsed)
aws_instance.ec2_aec_jenkins: Still destroying... (ID: i-0bd3159a4218f6e7a, 40s elapsed)
aws_instance.ec2_aec_student: Destruction complete
aws_security_group.aec_sg_student: Destroying... (ID: sg-03fb117d)
aws_security_group.aec_sg_student: Destruction complete
aws_instance.ec2_aec_jenkins: Destruction complete
aws_security_group.aec_sg_jenkins: Destroying... (ID: sg-15e70d6b)
aws_security_group.aec_sg_jenkins: Destruction complete

Destroy complete! Resources: 4 destroyed.```
