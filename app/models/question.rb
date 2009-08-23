class Question < ActiveRecord::Base
  belongs_to :winner, :class_name => 'User'

  validates_presence_of :title, :actors, :year

  named_scope :weekly, :conditions => ['updated_at > ?', 1.week.ago]
  named_scope :daily, :conditions => ['updated_at > ?', 1.day.ago]
  named_scope :all_time
  
  def send_tweet
    setup_twitter
    status = @twitter.status(:post, get_question)
    self.update_attribute(:tweet_id, status.id)
  end
  
  def get_question
    %Q{What movie did #{actors.split(/, /).to_sentence} star in #{year}?}
  end
  
  def match_title(status)
    !status.text.match(/#{title}/i).nil?
  end
  
  def tweet_winner(status)
    setup_twitter
    @twitter.status(:post, "The winner is @#{status.user.screen_name}.")
  end
  
  def finalize(status)
    u = User.find_by_twitter_id(status.user.id.to_s)
    self.update_attribute(:winner_id, u.id)
    u.update_attribute(:wins_count, u.wins_count + 1)
  end
  
  def self.next_random_question
    Rails.cache.fetch('current_question') { Question.find(((rand*(Question.count))+Question.first.id).truncate, :conditions => ['winner_id IS NULL']) }
  end
  
  protected
  
  def setup_twitter
    @twitter = Twitter::Client.from_config(File.join(RAILS_ROOT, 'config', 'twitter4r.yml'))
  end
end
