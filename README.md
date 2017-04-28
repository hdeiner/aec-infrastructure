# SolutionsIQ Agile Engineering Course Infrastructure Using Terraform 

This is a fairly simple Terraform example that can generate as many EC2 instances as necessary for the SolutionsIQ Agile Engineering Course. Some requirements that lead to this solution are:

  - Need for a development environment with appropriate tools (IDE, etc.)
  - Need to have zero installation on client machines (no software, no open ports, etc.)  Must run in browser.
  - Low cost.
  - Easy to setup before class starts.

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
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: 

Outputs:

addresses = [
    ec2-54-152-234-84.compute-1.amazonaws.com
]
```
6. Transfer all output addressess into infrastructure.feature for 
testing, as well as for informing students of what their machine's
URL will be.  On the command line, test the infrastrusture with 
```
mvn test
```
7. Students log on to their machine at port 8080 and a guacamole uri.
For example, a student would point their browser to
```
http://ec2-54-152-234-84.compute-1.amazonaws.com:8080/guacamole
```
8. Log on with USERNAME and PASSWORD.
9. When the infrastructure is no longer needed, destroy the 
infrastructure on the command line with
```
terraform destroy
```
10. You will have to type in "yes" and should see things like:
```
Do you really want to destroy?
  Terraform will delete all your managed infrastructure.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_security_group.aec_sg: Refreshing state... (ID: sg-bddd3fc3)
aws_instance.ec2_aec: Refreshing state... (ID: i-064c9e4939a7aae9b)
aws_instance.ec2_aec: Destroying... (ID: i-064c9e4939a7aae9b)
aws_instance.ec2_aec: Still destroying... (ID: i-064c9e4939a7aae9b, 10s elapsed)
aws_instance.ec2_aec: Still destroying... (ID: i-064c9e4939a7aae9b, 20s elapsed)
aws_instance.ec2_aec: Still destroying... (ID: i-064c9e4939a7aae9b, 30s elapsed)
aws_instance.ec2_aec: Destruction complete
aws_security_group.aec_sg: Destroying... (ID: sg-bddd3fc3)
aws_security_group.aec_sg: Destruction complete

Destroy complete! Resources: 2 destroyed.
```

# TODO
1) Reconfigure tomcat8 to use port 80 and the root directory.
2) Provision each machine to have more appropriate username/password combinations.
3) Preconfigure IntelliJ to point to the JDK installed on the machine.
 
