Feature: Agile Engineering Course Infrastructure as Code for TeamCity Machine

  Scenario Outline: Check TeamCity connectivity

    When I look at "<aecTeamCityInstance>"
    Then it should be running "sshd" on port "22"
    And it should be running "master" on port "25"
    And it should be running "java" on port "8111"
    And port "22" should be open
    And port "25" should be open
    And port "80" should be open

    Examples:
      |aecTeamCityInstance                        |
|ec2-54-174-169-28.compute-1.amazonaws.com|
|ec2-52-204-160-22.compute-1.amazonaws.com|
|ec2-34-227-191-5.compute-1.amazonaws.com|
