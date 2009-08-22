Feature: new trivia question
  I want tweet out new trivia question
  So that we can win RR
  Scenario: tweet question
    Given a new question
    When we start a new round
    Then we should tweet the question
    And we should update the tweet_id

# 
# Feature: import movie and actors from IMDB
#   I want import movie and actors from IMDB
#   So that we can have some questions
#   Scenario: import movie and actors from IMDB
#     Given a movie
#     When I import the movie
#     Then it should populate the questions table with imdb_id, title, and actors
# 
