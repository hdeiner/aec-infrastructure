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
|ec2-54-90-151-137.compute-1.amazonaws.com|
|ec2-54-147-209-24.compute-1.amazonaws.com|
|ec2-34-224-40-178.compute-1.amazonaws.com|
