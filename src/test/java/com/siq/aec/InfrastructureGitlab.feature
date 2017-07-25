Feature: Agile Engineering Course Infrastructure as Code for Gitlab Machine

  Scenario Outline: Check GitLab connectivity

    When I look at "<aecGitlabInstance>"
    Then it should be running "sshd" on port "22"
    And it should be running "master" on port "25"
    And it should be running "nginx" on port "80"
    And port "22" should be open
    And port "25" should be open
    And port "80" should be open

    Examples:
      |aecGitlabInstance                        |
|ec2-34-227-190-67.compute-1.amazonaws.com|
|ec2-54-175-210-132.compute-1.amazonaws.com|
|ec2-184-73-20-13.compute-1.amazonaws.com|
