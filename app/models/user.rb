class User < TwitterAuth::GenericUser
  has_many :winnings, :class_name => 'Question', :foreign_key => 'winner_id'
  named_scope :daily, :joins => 'INNER JOIN questions ON questions.winner_id = users.id', :conditions => ['questions.updated_at > ?', 1.day.ago.to_s(:db)]
  named_scope :weekly, :joins => 'INNER JOIN questions ON questions.winner_id = users.id', :conditions => ['questions.updated_at > ?', 1.week.ago.to_s(:db)]
  METHOD_MAP = { 'all-time' => :all, '24-hours' => :daily, 'last-week' => :weekly }
  
  def self.leaderboard(order='all-time')
    User.send(METHOD_MAP[order]).first(10).sort_by { |user| -user.winnings.send(METHOD_MAP[order]).size }
  end
end
