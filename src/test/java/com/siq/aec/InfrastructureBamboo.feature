Feature: Agile Engineering Course Infrastructure as Code for Bamboo Machine

  Scenario Outline: Check Bamboo connectivity

    When I look at "<aecBambooInstance>"
    Then it should be running "sshd" on port "22"
    And it should be running "master" on port "25"
    And it should be running "java" on port "8085"
    And port "22" should be open
    And port "25" should be open
    And port "80" should be open

    Examples:
      |aecBambooInstance                        |
|ec2-54-90-242-250.compute-1.amazonaws.com|
|ec2-34-201-50-238.compute-1.amazonaws.com|
|ec2-54-162-155-160.compute-1.amazonaws.com|
