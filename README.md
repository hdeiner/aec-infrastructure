# SolutionsIQ Agile Engineering Course Infrastructure Using Terraform 

This is a fairly simple Terraform example that can generate as many EC2 instances as necessary for the SolutionsIQ Agile Engineering Course. Some requirements that lead to this solution are:

  - Need for a development environment with appropriate tools (IDE, etc.)
  - Need to have zero installation on client machines (no software, no open ports, etc.)  Must run in browser.
  - Low cost.
  - Easy to setup before class starts.
  - Provide a continuous integration machine for class demos.
  - Provide a git remote repository machine for class demos.

# Design 
To meet these goals, the decision was made to run on AWS EC2 instances.  These instances are treated as Infrastructure as Code (hence this project).  As written, the instances run Ubuntu 16.04.  There is not a publically available AWS AMI that includes the Ubuntu Desktop.  This project provisions a complete desktop, along with IntelliJ for students to easily write and debug code with.

To gain access to the desktop, virutal network computing (VNC) protocol is layered on top of the X11 desktop.  To provide a solution that is purely web based, Apache Guacamole is then layered on top of that to render the VNC into HTML5.  This also provides the ability to have several students share desktops, for classroom aid, as well as remote pairing.  Students merely have to point their browser to http://[AWS EC2 Public DNS Name]:8080/guacamole.  Use USERNAME and PASSWORD for access.

# Use
1. Make sure that you can use AWS CLI without issue.  In particular,
you need valid ~/.aws config and credentials files.
2. Make sure that you have SSH keys generated in your ~/.ssh.  This can be done by: 
```
ssh-keygen -t rsa
```
3. Make sure that Terraform is installed.
4. Ensure that terraformProvider.tf has appropriate settings for your use.  For example,
the AWS region may have to change, and that will require a change in the 
AMI used.
5. On the command line, create the infrastructure with
 ```
 terraform apply
 ```
6. After a whole lot of provisioning, you should see things such as the following.  This was run with two student instances being created. 
```
Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: 

Outputs:

gitlab_address = [
    ec2-54-175-158-139.compute-1.amazonaws.com
]
gitlab_ip = [
    54.175.158.139
]
jenkins_address = [
    ec2-54-144-23-36.compute-1.amazonaws.com
]
jenkins_ip = [
    54.144.23.36
]
student_addresses = [
    ec2-184-73-144-130.compute-1.amazonaws.com
]
student_ips = [
    184.73.144.130
]
teamcity_address = [
    ec2-34-201-43-178.compute-1.amazonaws.com
]
teamcity_ip = [
    34.201.43.178
]
```
7. Integrated automated testing of the infrastructure is built into the system.
To test, from the command line, enter
```
mvn
```
8. Cucumber feature files will be built in the validate exec:java phase and run in the test phase.  You should see things like the following in response to your "mvn" command:

```

-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running com.siq.aec.TestRunner
Feature: Agile Engineering Course Infrastructure as Code for Gitlab Machine

  Scenario Outline: Check GitLab connectivity      # InfrastructureGitlab.feature:3
    When I look at "<aecGitlabInstance>"
    Then it should be running "sshd" on port "22"
    And it should be running "master" on port "25"
    And it should be running "nginx" on port "80"
    And port "22" should be open
    And port "25" should be open
    And port "80" should be open

    Examples: 
!!! Warning: Permanently added 'ec2-54-175-158-139.compute-1.amazonaws.com,54.175.158.139' (ECDSA) to the list of known hosts.

  Scenario Outline: Check GitLab connectivity                   # InfrastructureGitlab.feature:15
    When I look at "ec2-54-175-158-139.compute-1.amazonaws.com" # Stepdefs.i_look_at(String)
    Then it should be running "sshd" on port "22"               # Stepdefs.it_should_be_running_on_port(String,String)
    And it should be running "master" on port "25"              # Stepdefs.it_should_be_running_on_port(String,String)
    And it should be running "nginx" on port "80"               # Stepdefs.it_should_be_running_on_port(String,String)
    And port "22" should be open                                # Stepdefs.port_should_be_open(String)
    And port "25" should be open                                # Stepdefs.port_should_be_open(String)
    And port "80" should be open                                # Stepdefs.port_should_be_open(String)
Feature: Agile Engineering Course Infrastructure as Code for Jenkins Machine

  Scenario Outline: Check Jenkins connectivity     # InfrastructureJenkins.feature:3
    When I look at "<aecJenkinsInstance>"
    Then it should be running "sshd" on port "22"
    And it should be running "master" on port "25"
    And it should be running "java" on port "8080"
    And port "22" should be open
    And port "25" should be open
    And port "80" should be open

    Examples: 
!!! Warning: Permanently added 'ec2-54-144-23-36.compute-1.amazonaws.com,54.144.23.36' (ECDSA) to the list of known hosts.

  Scenario Outline: Check Jenkins connectivity                # InfrastructureJenkins.feature:16
    When I look at "ec2-54-144-23-36.compute-1.amazonaws.com" # Stepdefs.i_look_at(String)
    Then it should be running "sshd" on port "22"             # Stepdefs.it_should_be_running_on_port(String,String)
    And it should be running "master" on port "25"            # Stepdefs.it_should_be_running_on_port(String,String)
    And it should be running "java" on port "8080"            # Stepdefs.it_should_be_running_on_port(String,String)
    And port "22" should be open                              # Stepdefs.port_should_be_open(String)
    And port "25" should be open                              # Stepdefs.port_should_be_open(String)
    And port "80" should be open                              # Stepdefs.port_should_be_open(String)
Feature: Agile Engineering Course Infrastructure as Code for Student Machines

  Scenario Outline: Check Student connectivity          # InfrastructureStudent.feature:3
    When I look at "<aecStudentInstance>"
    Then it should be running "sshd" on port "22"
    And it should be running "guacd" on port "4822"
    And it should be running "Xtightvnc" on port "5901"
    And it should be running "java" on port "8080"
    And port "22" should be open
    And port "80" should be open

    Examples: 
!!! Warning: Permanently added 'ec2-184-73-144-130.compute-1.amazonaws.com,184.73.144.130' (ECDSA) to the list of known hosts.

  Scenario Outline: Check Student connectivity                  # InfrastructureStudent.feature:15
    When I look at "ec2-184-73-144-130.compute-1.amazonaws.com" # Stepdefs.i_look_at(String)
    Then it should be running "sshd" on port "22"               # Stepdefs.it_should_be_running_on_port(String,String)
    And it should be running "guacd" on port "4822"             # Stepdefs.it_should_be_running_on_port(String,String)
    And it should be running "Xtightvnc" on port "5901"         # Stepdefs.it_should_be_running_on_port(String,String)
    And it should be running "java" on port "8080"              # Stepdefs.it_should_be_running_on_port(String,String)
    And port "22" should be open                                # Stepdefs.port_should_be_open(String)
    And port "80" should be open                                # Stepdefs.port_should_be_open(String)
Feature: Agile Engineering Course Infrastructure as Code for TeamCity Machine

  Scenario Outline: Check TeamCity connectivity    # InfrastructureTeamCity.feature:3
    When I look at "<aecTeamCityInstance>"
    Then it should be running "sshd" on port "22"
    And it should be running "master" on port "25"
    And it should be running "java" on port "8111"
    And port "22" should be open
    And port "25" should be open
    And port "80" should be open

    Examples: 
!!! Warning: Permanently added 'ec2-34-201-43-178.compute-1.amazonaws.com,34.201.43.178' (ECDSA) to the list of known hosts.

  Scenario Outline: Check TeamCity connectivity                # InfrastructureTeamCity.feature:15
    When I look at "ec2-34-201-43-178.compute-1.amazonaws.com" # Stepdefs.i_look_at(String)
    Then it should be running "sshd" on port "22"              # Stepdefs.it_should_be_running_on_port(String,String)
    And it should be running "master" on port "25"             # Stepdefs.it_should_be_running_on_port(String,String)
    And it should be running "java" on port "8111"             # Stepdefs.it_should_be_running_on_port(String,String)
    And port "22" should be open                               # Stepdefs.port_should_be_open(String)
    And port "25" should be open                               # Stepdefs.port_should_be_open(String)
    And port "80" should be open                               # Stepdefs.port_should_be_open(String)

4 Scenarios (4 passed)
28 Steps (28 passed)
0m7.403s

Tests run: 32, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 9.635 sec

Results :

Tests run: 32, Failures: 0, Errors: 0, Skipped: 0

[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 17.490 s
[INFO] Finished at: 2017-05-05T18:45:04-04:00
[INFO] Final Memory: 20M/188M
[INFO] ------------------------------------------------------------------------```
```
9. Use the following terraform commands to aid in the creation of
eMails, etc. (responses are should after the command):
```
terraform output gitlab_address
ec2-34-207-89-114.compute-1.amazonaws.com
terraform output jenkins_address
ec2-34-201-93-235.compute-1.amazonaws.com
terraform output student_addresses
ec2-54-82-248-68.compute-1.amazonaws.com
terraform output teamcity_address
ec2-34-203-217-157.compute-1.amazonaws.com
```
10. Students log on to their machine through a browser that supports HTML5.
For example, a student would point their browser to
```
http://ec2-54-152-234-84.compute-1.amazonaws.com
```
11. Log on with USERNAME and PASSWORD.
12. It is assumed that you know how to use and configure Jenkins.  Point your browser to the URL created and provisioned by Terraform.  You will have to ssh into the Jenkins server once to supply the secret password to the browser to unlock Jenkins.
12. It is also assumed that you know how to use and configure TeamCity.  Point your browser to the URL created and provisioned by Terraform.  TeamCity is much easier to use, and prettier as well.  You will not need to unlock the application with a copy and paste from the output of an ssh session into the server.
14. It is also assumed that you know how to use and configure GitLab.  Point your browser to the URL created and provisioned by Terraform.  
15. When the infrastructure is no longer needed, destroy the 
infrastructure on the command line with
```
terraform destroy
```
16. You will have to type in "yes" and should see things like:
```
terraform destroy
Do you really want to destroy?
  Terraform will delete all your managed infrastructure.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_security_group.aec_sg_gitlab: Refreshing state... (ID: sg-1e2b8f60)
aws_security_group.aec_sg_student: Refreshing state... (ID: sg-ef2a8e91)
aws_security_group.aec_sg_jenkins: Refreshing state... (ID: sg-993591e7)
aws_security_group.aec_sg_teamcity: Refreshing state... (ID: sg-b5298dcb)
aws_key_pair.aec_key_pair: Refreshing state... (ID: aec_key_pair)
aws_instance.ec2_aec_gitlab: Refreshing state... (ID: i-01a75a9cd42d2006f)
aws_instance.ec2_aec_teamcity: Refreshing state... (ID: i-06fb706eed1b25e54)
aws_instance.ec2_aec_jenkins: Refreshing state... (ID: i-022d3e0d11eab8722)
aws_instance.ec2_aec_student: Refreshing state... (ID: i-0a0c0904390d45013)
aws_instance.ec2_aec_gitlab: Destroying... (ID: i-01a75a9cd42d2006f)
aws_instance.ec2_aec_student: Destroying... (ID: i-0a0c0904390d45013)
aws_instance.ec2_aec_teamcity: Destroying... (ID: i-06fb706eed1b25e54)
aws_instance.ec2_aec_jenkins: Destroying... (ID: i-022d3e0d11eab8722)
aws_instance.ec2_aec_teamcity: Still destroying... (ID: i-06fb706eed1b25e54, 10s elapsed)
aws_instance.ec2_aec_jenkins: Still destroying... (ID: i-022d3e0d11eab8722, 10s elapsed)
aws_instance.ec2_aec_student: Still destroying... (ID: i-0a0c0904390d45013, 10s elapsed)
aws_instance.ec2_aec_gitlab: Still destroying... (ID: i-01a75a9cd42d2006f, 10s elapsed)
aws_instance.ec2_aec_jenkins: Still destroying... (ID: i-022d3e0d11eab8722, 20s elapsed)
aws_instance.ec2_aec_gitlab: Still destroying... (ID: i-01a75a9cd42d2006f, 20s elapsed)
aws_instance.ec2_aec_teamcity: Still destroying... (ID: i-06fb706eed1b25e54, 20s elapsed)
aws_instance.ec2_aec_student: Still destroying... (ID: i-0a0c0904390d45013, 20s elapsed)
aws_instance.ec2_aec_student: Still destroying... (ID: i-0a0c0904390d45013, 30s elapsed)
aws_instance.ec2_aec_gitlab: Still destroying... (ID: i-01a75a9cd42d2006f, 30s elapsed)
aws_instance.ec2_aec_teamcity: Still destroying... (ID: i-06fb706eed1b25e54, 30s elapsed)
aws_instance.ec2_aec_jenkins: Still destroying... (ID: i-022d3e0d11eab8722, 30s elapsed)
aws_instance.ec2_aec_student: Destruction complete
aws_security_group.aec_sg_student: Destroying... (ID: sg-ef2a8e91)
aws_instance.ec2_aec_teamcity: Destruction complete
aws_security_group.aec_sg_teamcity: Destroying... (ID: sg-b5298dcb)
aws_security_group.aec_sg_student: Destruction complete
aws_security_group.aec_sg_teamcity: Destruction complete
aws_instance.ec2_aec_jenkins: Still destroying... (ID: i-022d3e0d11eab8722, 40s elapsed)
aws_instance.ec2_aec_gitlab: Still destroying... (ID: i-01a75a9cd42d2006f, 40s elapsed)
aws_instance.ec2_aec_gitlab: Destruction complete
aws_security_group.aec_sg_gitlab: Destroying... (ID: sg-1e2b8f60)
aws_security_group.aec_sg_gitlab: Destruction complete
aws_instance.ec2_aec_jenkins: Still destroying... (ID: i-022d3e0d11eab8722, 50s elapsed)
aws_instance.ec2_aec_jenkins: Still destroying... (ID: i-022d3e0d11eab8722, 1m0s elapsed)
aws_instance.ec2_aec_jenkins: Destruction complete
aws_security_group.aec_sg_jenkins: Destroying... (ID: sg-993591e7)
aws_key_pair.aec_key_pair: Destroying... (ID: aec_key_pair)
aws_key_pair.aec_key_pair: Destruction complete
aws_security_group.aec_sg_jenkins: Destruction complete

Destroy complete! Resources: 9 destroyed.
```



# Running with Dockerfile

1. Build the image
```
docker build -t aec .
```
2. Start Container & Get shell
```
docker run -it aec bash
```
3. Setup your aws-cli
* You'll need to enter your AWS ACCESS KEY ID AND AWS SECRET ACCESS KEY 
* Use us-east-1
* Set output to json
```
aws configure
```
4. Initialize & Run the Terraform scripts
```
terraform init
```
```
terraform apply
```
5. Test everything
```
mvn
```
6. Destroy (must type yes)
```
terraform destroy
```