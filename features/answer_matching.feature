Feature: answer matching
  I want to determine if an answer is correct
  So that we can announce winner
  Scenario: right answer
    Given an answer "mall cop"
    And the movie title was "mall cop"
    When we compare them the answers
    Then match should return "true"
    And we should announce the winner
    And we record the winner
  Scenario: right answer without html encoding
    Given an answer "Who's Afraid of Virginia Woolf?"
    And the movie title was "Who&#x27;s Afraid of Virginia Woolf?"
    When we compare them the answers
    Then match should return "true"
    And we should announce the winner
    And we record the winner
  Scenario: wrong answer
    Given an answer "austin power"
    And the movie title was "mall cop"
    When we compare them the answers
    Then match should return "false"
