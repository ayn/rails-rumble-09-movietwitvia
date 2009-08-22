Given /^a list of winners$/ do
  15.times do |i|
    u = User.new(:twitter_id => i.to_s, :login => i.to_s, :wins_count => (rand*10).truncate)
    u.twitter_id = i.to_s
    u.save
  end
end

Given /^a sorting criteria "([^\"]*)"$/ do |order|
  case order
  when '24 hours' : @conditions = 'TBD'
  when 'week' : @conditions = 'TBD'
  when 'all-time' : @conditions = ['wins_count DESC']
  end
end

When /^we show the "([^\"]*)" leaderboard$/ do |order|
  @winners = User.leaderboard_all_time
end

Then /^the winners should be sorted with most winnings first$/ do
  @winners.each_cons(2) { |winners| winners[0].wins_count.should <= winners[1].wins_count }
end
