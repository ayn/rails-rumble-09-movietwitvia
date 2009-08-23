Given /^a new question$/ do
  @question = Question.new
  @question.title = "Shrek"
  @question.actors = "Mike Meyers, Eddie Murphy"
end

When /^we start a new round$/ do
  Twitter::Client.expects(:from_config).with(File.join(RAILS_ROOT, 'config', 'twitter4r.yml'), 'test').returns(@t = mock('twitter'))
  @t.expects(:status).with(:post, @question.get_question).returns(stub(:id => '123'))  
end

Then /^we should tweet the question$/ do
  @question.send_tweet
end

Then /^we should update the tweet_id$/ do
  @question.tweet_id.should == '123'
end
