Given /^a list of winners$/ do
  15.times do |i|
    u = User.new(:twitter_id => i.to_s, :login => i.to_s)
    u.twitter_id = i.to_s
    u.save
  end

  30.times do |i|
    Question.create(:winner_id => (rand*15).truncate, :updated_at => (rand*3).days.ago)
  end
end

When /^we show the "([^\"]*)" leaderboard$/ do |time_period|
  @time_period = time_period
  @winners = User.leaderboard(time_period)
end

Then /^the winners should be sorted with most winnings first$/ do
  @winners.each_cons(2) { |winners| winners[0].winnings.send(User::METHOD_MAP[@time_period]).size.should <= winners[1].winnings.send(User::METHOD_MAP[@time_period]).size }
end