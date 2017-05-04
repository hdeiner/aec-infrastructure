Feature: Agile Engineering Course Infrastructure as Code for Student Machines

  Scenario Outline: Check Student connectivity

    When I look at "<aecStudentInstance>"
    Then there should be ssh connectivity
    And there should be vnc connectivity
    And there should be guacd connectivity
    And there should be http8080 connectivity

    Examples:
      |aecStudentInstance                        |
|ec2-54-165-232-113.compute-1.amazonaws.com|
