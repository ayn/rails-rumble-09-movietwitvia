class Question < ActiveRecord::Base
  belongs_to :winner, :class_name => 'User'
  
  def send_tweet
    twitter = Twitter::Client.from_config(File.join(RAILS_ROOT, 'config', 'twitter4r.yml'))
    status = twitter.status(:post, get_question)
    self.update_attribute(:tweet_id, status.id)
  end
  
  def get_question
    %Q{What movie did #{actors.split(/, /).to_sentence} star in #{year}?}
  end
end
