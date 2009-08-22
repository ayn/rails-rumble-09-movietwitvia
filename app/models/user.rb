class User < TwitterAuth::GenericUser
  # Extend and define your user model as you see fit.
  # All of the authentication logic is handled by the 
  # parent TwitterAuth::GenericUser class.
  
  has_many :winnings, :class_name => :questions, :foreign_key => 'winner_id'
end
