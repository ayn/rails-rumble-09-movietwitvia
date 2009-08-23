class Question < ActiveRecord::Base
  belongs_to :winner, :class_name => 'User'

  validates_presence_of :title, :actors, :year

  named_scope :weekly, :conditions => ['updated_at > ?', 1.week.ago]
  named_scope :daily, :conditions => ['updated_at > ?', 1.day.ago]
  named_scope :all_time
  
  def send_tweet
    setup_twitter
    status = @twitter.status(:post, get_question)
    self.update_attributes({ :tweet_id => status.id, :is_current => true })
  end
  
  def get_question(options={})
    r = %Q{What movie did #{actors.split(/, /).to_sentence} star in #{year}? #MovieTwitvia #RailsRumble}
    options.delete(:insert_spans) ? r.gsub(/#\w+/) { |s| "<span>#{s}</span>" } : r
  end
  
  def match_title(text)
    !text.match(/#{CGI.unescapeHTML(title)}/i).nil?
  end
  
  def tweet_winner(screen_name)
    setup_twitter
    name = title[0..59]
    s = "#MovieTwitvia #RailsRumble @#{screen_name} won! The movie was #{name}. http://www.amazon.com/s/?url=search-alias=aps&field-keywords=#{URI.encode(title)}&tag=carmudgeonsco-20&link_code=wql&camp=212361&creative=380601&_encoding=UTF-8"
    @twitter.status(:post, s)
  end
  
  def finalize(twuser_id)
    if u = User.find_by_twitter_id(twuser_id)
      self.update_attribute(:winner_id, u.id)
      u.update_attribute(:wins_count, u.wins_count.to_i + 1)
    end
  end
  
  def self.next_random_question
    current_question = Question.find_by_is_current(true)
    unless current_question
      current_question = Question.find(((rand*(Question.count))+Question.first.id).truncate, :conditions => ['winner_id IS NULL']) 
      current_question.update_attribute(:is_current, true)
    end
    current_question
  end
  
  protected
  
  def setup_twitter
    @twitter = Twitter::Client.from_config(File.join(RAILS_ROOT, 'config', 'twitter4r.yml'), RAILS_ENV)
  end
end
