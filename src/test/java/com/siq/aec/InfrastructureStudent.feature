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
|ec2-54-196-100-220.compute-1.amazonaws.com|
|ec2-54-81-34-188.compute-1.amazonaws.com|
|ec2-52-71-166-113.compute-1.amazonaws.com|
|ec2-54-209-180-101.compute-1.amazonaws.com|
|ec2-54-227-168-232.compute-1.amazonaws.com|
|ec2-54-91-156-21.compute-1.amazonaws.com|
|ec2-54-242-179-248.compute-1.amazonaws.com|
|ec2-34-226-203-124.compute-1.amazonaws.com|
|ec2-184-73-100-50.compute-1.amazonaws.com|
|ec2-54-89-118-35.compute-1.amazonaws.com|
|ec2-52-90-39-98.compute-1.amazonaws.com|
|ec2-52-55-22-167.compute-1.amazonaws.com|
|ec2-54-88-176-169.compute-1.amazonaws.com|
|ec2-52-71-166-26.compute-1.amazonaws.com|
|ec2-54-146-44-177.compute-1.amazonaws.com|
|ec2-52-90-243-1.compute-1.amazonaws.com|
|ec2-34-203-209-75.compute-1.amazonaws.com|
|ec2-54-87-137-240.compute-1.amazonaws.com|
|ec2-52-205-11-150.compute-1.amazonaws.com|
|ec2-54-159-192-204.compute-1.amazonaws.com|
|ec2-52-203-193-17.compute-1.amazonaws.com|
|ec2-54-227-37-244.compute-1.amazonaws.com|
|ec2-204-236-211-38.compute-1.amazonaws.com|
|ec2-52-206-238-175.compute-1.amazonaws.com|
|ec2-54-211-169-211.compute-1.amazonaws.com|
