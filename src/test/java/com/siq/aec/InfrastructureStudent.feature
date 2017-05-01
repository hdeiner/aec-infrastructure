Feature: Agile Engineering Course Infrastructure as Code for Student Machines

  Scenario Outline: Check connectivity

    When I look at "<aecStudentInstance>"
    Then there should be ssh connectivity
    And there should be vnc connectivity
    And there should be guacd connectivity
    And there should be http8080 connectivity

    Examples:
      |aecStudentInstance                        |
|ec2-54-152-8-96.compute-1.amazonaws.com|
|ec2-54-86-101-79.compute-1.amazonaws.com|
