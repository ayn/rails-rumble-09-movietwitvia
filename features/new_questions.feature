Feature: new trivia question
  I want tweet out new trivia question
  So that we can win RR
  Scenario: tweet question
    Given a new question
    When we start a new round
    Then we should tweet the question
    And we should update the tweet_id

# Feature: answer scoring
#   I want to determine if an answer is correct
#   So that we can announce winner
#   Scenario: right answer
#     Given an answer "mall cop"
#     And the movie title was "mall cop"
#     When we compare them the answers
#     Then they should match
#     And we should announce the winner
#   Scenario: wrong answer
#     Given an answer "austin power"
#     And the movie title was "mall cop"
#     When we compare them the answers
#     Then they should not match
# 
# Feature: import movie and actors from IMDB
#   I want import movie and actors from IMDB
#   So that we can have some questions
#   Scenario: import movie and actors from IMDB
#     Given a movie
#     When I import the movie
#     Then it should populate the questions table with imdb_id, title, and actors
# 
