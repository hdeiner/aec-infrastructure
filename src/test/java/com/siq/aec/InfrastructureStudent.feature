Feature: Agile Engineering Course Infrastructure as Code for Student Machines

  Scenario Outline: Check Student connectivity

    When I look at "<aecStudentInstance>"
    Then it should be running "sshd" on port "22"
    And it should be running "guacd" on port "4822"
    And it should be running "Xtightvnc" on port "5901"
    And it should be running "java" on port "8080"
    And port "22" should be open
    And port "80" should be open

    Examples:
      |aecStudentInstance                        |
|ec2-54-164-140-48.compute-1.amazonaws.com|
|ec2-34-228-185-243.compute-1.amazonaws.com|
|ec2-54-164-164-72.compute-1.amazonaws.com|
|ec2-34-201-111-142.compute-1.amazonaws.com|
|ec2-54-152-237-108.compute-1.amazonaws.com|
|ec2-52-90-236-202.compute-1.amazonaws.com|
|ec2-34-224-66-185.compute-1.amazonaws.com|
|ec2-34-228-12-14.compute-1.amazonaws.com|
|ec2-34-203-248-196.compute-1.amazonaws.com|
|ec2-34-228-17-248.compute-1.amazonaws.com|
|ec2-54-82-170-248.compute-1.amazonaws.com|
|ec2-34-228-58-220.compute-1.amazonaws.com|
|ec2-34-227-192-92.compute-1.amazonaws.com|
|ec2-34-204-10-189.compute-1.amazonaws.com|
|ec2-54-235-57-120.compute-1.amazonaws.com|
|ec2-34-226-205-171.compute-1.amazonaws.com|
|ec2-52-207-144-0.compute-1.amazonaws.com|
|ec2-34-224-27-254.compute-1.amazonaws.com|
|ec2-34-224-212-33.compute-1.amazonaws.com|
|ec2-34-227-8-83.compute-1.amazonaws.com|
|ec2-34-207-252-180.compute-1.amazonaws.com|
|ec2-52-90-221-240.compute-1.amazonaws.com|
|ec2-52-90-160-219.compute-1.amazonaws.com|
|ec2-52-91-159-201.compute-1.amazonaws.com|
|ec2-34-228-61-19.compute-1.amazonaws.com|
|ec2-34-201-82-167.compute-1.amazonaws.com|
|ec2-54-210-20-168.compute-1.amazonaws.com|
|ec2-54-175-210-210.compute-1.amazonaws.com|
