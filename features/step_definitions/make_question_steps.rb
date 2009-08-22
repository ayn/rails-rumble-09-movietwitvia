Given /^a movie title "([^\"]*)", year "([^\"]*)", and actors "([^\"]*)"$/ do |title, year, actors|
  @question = Question.new
  @question.title = title
  @question.year = year
  @question.actors = actors
end

When /^I want a question$/ do
  @sentence = @question.get_question
end

Then /^it should return "([^\"]*)"$/ do |sentence|
  @sentence.should == sentence
end
