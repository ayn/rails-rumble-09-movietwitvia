Feature: construct a question
  I want to construct a question
  Scenario: construct a question
    Given a movie title "Shrek", year "2003", and actors "Mike Meyers, Eddie Murphy"
    When I want a question
    Then it should return "What movie did Mike Meyers and Eddie Murphy star in 2003? #MovieTwitvia"
