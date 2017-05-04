Feature: Agile Engineering Course Infrastructure as Code for TeamCity Machine

  Scenario Outline: Check TeamCity connectivity

    When I look at "<aecTeamCityInstance>"
    Then there should be ssh connectivity
    And there should be smtp connectivity
    And there should be http8111 connectivity

    Examples:
      |aecTeamCityInstance                        |
|ec2-54-157-223-214.compute-1.amazonaws.com|
