Feature: Agile Engineering Course Infrastructure as Code for Jenkins Machine

  Scenario Outline: Check Jenkins connectivity

    When I look at "<aecJenkinsInstance>"
    Then it should be running "sshd" on port "22"
    And it should be running "master" on port "25"
    And it should be running "java" on port "8080"
    And port "22" should be open
    And port "25" should be open
    And port "80" should be open


    Examples:
      |aecJenkinsInstance                        |
|ec2-34-227-103-251.compute-1.amazonaws.com|
|ec2-34-226-208-143.compute-1.amazonaws.com|
|ec2-34-226-209-148.compute-1.amazonaws.com|
