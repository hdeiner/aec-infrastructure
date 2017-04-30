Feature: Agile Engineering Course Infrastructure as Code for Student Machines

  Scenario Outline: Check connectivity

    When I look at "<aecStudentInstance>"
    Then there should be ssh connectivity
    And there should be vnc connectivity
    And there should be guacd connectivity
    And there should be http connectivity

    Examples:
      |aecStudentInstance                        |
      |ec2-54-234-29-7.compute-1.amazonaws.com   |
      |ec2-34-201-113-103.compute-1.amazonaws.com|