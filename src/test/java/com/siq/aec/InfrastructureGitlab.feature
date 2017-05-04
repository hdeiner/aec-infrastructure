Feature: Agile Engineering Course Infrastructure as Code for Gitlab Machine

  Scenario Outline: Check GitLab connectivity

    When I look at "<aecGitlabInstance>"
    Then there should be ssh connectivity
    And there should be smtp connectivity
    And there should be http80 connectivity
#    Then it should be running "sshd" on port "22"
#    And it should be running "master" on port "25"
#    And it should be running "java" on port "8080"
#    And port "22" should be open
#    And port "25" should be open
#    And port "80" should be open

    Examples:
      |aecGitlabInstance                        |
|ec2-34-207-89-114.compute-1.amazonaws.com|
