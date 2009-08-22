class StaticController < ApplicationController
  def index
    @users = User.all(:order => "created_at DESC", :limit => 16)
    @leaders = User.leaderboard(params[:time_period] || 'all-time')
    @question = Rails.cache.read('current_question') || Question.next_random_question
  end
end
