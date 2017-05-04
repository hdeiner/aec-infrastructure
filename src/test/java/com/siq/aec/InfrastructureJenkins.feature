Feature: Agile Engineering Course Infrastructure as Code for Jenkins Machine

  Scenario Outline: Check Jenkins connectivity

    When I look at "<aecJenkinsInstance>"
    Then there should be ssh connectivity
    And there should be smtp connectivity
    And there should be http8080 connectivity

    Examples:
      |aecJenkinsInstance                        |
|ec2-54-164-56-103.compute-1.amazonaws.com|
