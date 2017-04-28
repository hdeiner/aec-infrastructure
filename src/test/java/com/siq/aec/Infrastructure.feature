Feature: Agile Engineering Course Infrastructure as Code

  Scenario Outline: Check connectivity

    When I look at "<aecInstance>"
    Then there should be ssh connectivity
    And there should be vnc connectivity
    And there should be guacd connectivity
    And there should be http connectivity

    Examples:
      |aecInstance                               |
      |ec2-54-152-234-84.compute-1.amazonaws.com |