Feature: Agile Engineering Course Infrastructure as Code for Gitlab Machine

  Scenario Outline: Check GitLab connectivity

    When I look at "<aecGitlabInstance>"
    Then there should be ssh connectivity
    And there should be smtp connectivity
    And there should be http80 connectivity

    Examples:
      |aecGitlabInstance                        |
|ec2-52-91-46-201.compute-1.amazonaws.com|
