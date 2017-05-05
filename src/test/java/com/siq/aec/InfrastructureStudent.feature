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
|ec2-184-73-144-130.compute-1.amazonaws.com|
