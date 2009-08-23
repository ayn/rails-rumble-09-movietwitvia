Given /^an answer "([^\"]*)"$/ do |answer|
  @json_hash = { "text" => answer,
                 "id" => 46672912,
                 "user" => {"name" => "Angie",
                            "description" => "TV junkie...",
                            "location" => "NoVA",
                            "profile_image_url" => "http:\/\/assets0.twitter.com\/system\/user\/profile_image\/5483072\/normal\/eye.jpg?1177462492",
                            "url" => nil,
                            "id" => 5483072,
                            "protected" => false,
                            "screen_name" => "ang_410"},
                 "created_at" => "Wed May 02 03:04:54 +0000 2007"}

  @status = Twitter::Status.new @json_hash
end

Given /^the movie title was "([^\"]*)"$/ do |title|
  @movie = Question.create(:title => title)
end

When /^we compare them the answers$/ do
  @result = @movie.match_title(@status.text)
end

Then /^we should announce the winner$/ do
  Twitter::Client.expects(:from_config).with(File.join(RAILS_ROOT, 'config', 'twitter4r.yml')).returns(@t = mock('twitter'))
  @t.expects(:status).with(:post, "The winner is @ang_410.").returns(stub(:id => '123'))
  @movie.tweet_winner(@status.user.screen_name)
end

Then /^match should return "([^\"]*)"$/ do |truth|
  @result.should == (truth == 'true') ? true : false
end

Then /^we record the winner$/ do
  User.expects(:find_by_twitter_id).with("5483072").returns(@u=stub(:id => 123, :wins_count => 0))
  @u.expects(:update_attribute).with(:wins_count, 1)
  @movie.finalize(@status.user.id.to_s)
  @movie.reload.winner_id.should == 123
end

#TBD: maybe verify the user's winning_count