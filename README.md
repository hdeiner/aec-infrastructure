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
6. After a whole lot of provisioning, you should see things such as the following.  This was run with two student instances being created. 
```
Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: 

Outputs:

jenkins_address = [
    ec2-34-201-111-228.compute-1.amazonaws.com
]
student_addresses = [
    ec2-54-234-29-7.compute-1.amazonaws.com,
    ec2-34-201-113-103.compute-1.amazonaws.com
]
```
7. Integrated automated testing of the infrastructure is built into the system.
To test, from the command line, enter
```
mvn
```
8. Cucumber feature files will be built in the validate exec:java phase and run in the test phase.
You should see results of the tests, such as
```
-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running com.siq.aec.TestRunner
Feature: Agile Engineering Course Infrastructure as Code for Jenkins Machine

  Scenario Outline: Check connectivity    # InfrastructureJenkins.feature:3
    When I look at "<aecJenkinsInstance>"
    Then there should be ssh connectivity
    And there should be smtp connectivity
    And there should be http connectivity

    Examples: 

  Scenario Outline: Check connectivity                          # InfrastructureJenkins.feature:12
    When I look at "ec2-54-146-181-140.compute-1.amazonaws.com" # Stepdefs.i_look_at(String)
    Then there should be ssh connectivity                       # Stepdefs.there_should_be_ssh_connectivity()
    And there should be smtp connectivity                       # Stepdefs.there_should_be_smtp_connectivity()
    And there should be http connectivity                       # Stepdefs.there_should_be_http_connectivity()
Feature: Agile Engineering Course Infrastructure as Code for Student Machines

  Scenario Outline: Check connectivity     # InfrastructureStudent.feature:3
    When I look at "<aecStudentInstance>"
    Then there should be ssh connectivity
    And there should be vnc connectivity
    And there should be guacd connectivity
    And there should be http connectivity

    Examples: 

  Scenario Outline: Check connectivity                        # InfrastructureStudent.feature:13
    When I look at "ec2-54-172-9-163.compute-1.amazonaws.com" # Stepdefs.i_look_at(String)
    Then there should be ssh connectivity                     # Stepdefs.there_should_be_ssh_connectivity()
    And there should be vnc connectivity                      # Stepdefs.there_should_be_vnc_connectivity()
    And there should be guacd connectivity                    # Stepdefs.there_should_be_guacd_connectivity()
    And there should be http connectivity                     # Stepdefs.there_should_be_http_connectivity()

  Scenario Outline: Check connectivity                          # InfrastructureStudent.feature:14
    When I look at "ec2-52-201-223-223.compute-1.amazonaws.com" # Stepdefs.i_look_at(String)
    Then there should be ssh connectivity                       # Stepdefs.there_should_be_ssh_connectivity()
    And there should be vnc connectivity                        # Stepdefs.there_should_be_vnc_connectivity()
    And there should be guacd connectivity                      # Stepdefs.there_should_be_guacd_connectivity()
    And there should be http connectivity                       # Stepdefs.there_should_be_http_connectivity()

3 Scenarios (3 passed)
14 Steps (14 passed)
0m1.777s

Tests run: 17, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 2.195 sec

Results :

Tests run: 17, Failures: 0, Errors: 0, Skipped: 0
```
9. Use the following terraform commands to aid in the creation of
eMails, etc.:
```
Howards-Mac:aec-infrastructure howarddeiner$ terraform output jenkins_address
ec2-34-201-111-228.compute-1.amazonaws.com
Howards-Mac:aec-infrastructure howarddeiner$ terraform output student_addresses
ec2-54-234-29-7.compute-1.amazonaws.com,
ec2-34-201-113-103.compute-1.amazonaws.com
```
10. Students log on to their machine at port 8080 and a guacamole uri.
For example, a student would point their browser to
```
http://ec2-54-152-234-84.compute-1.amazonaws.com:8080/guacamole
```
11. Log on with USERNAME and PASSWORD.
12. It is assumed that you know how to use and configure Jenkins.  Point your browser to the URL:8080 created and provisioned by Terraform.  You will have to ssh into the Jenkins server once to supply the secret password to the browser.
13. When the infrastructure is no longer needed, destroy the 
infrastructure on the command line with
```
terraform destroy
```
14. You will have to type in "yes" and should see things like:
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
