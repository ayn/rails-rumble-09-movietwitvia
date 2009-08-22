Feature: Leaderboard with winners ranked
  As a leaderboard
  I want to show the winningest players in the last 24 hours, in the current week, and all time
  So that they can feel proud of themselves and have a bit exposure
  Scenario: 24-hour leaderboard
    Given a list of winners
    And a sorting criteria "all-time"
    When we show the "all-time" leaderboard
    Then the winners should be sorted with most winnings first
