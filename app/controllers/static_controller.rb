class StaticController < ApplicationController
  def index
    @users = User.all(:order => "created_at DESC", :limit => 16)
    @leaders = User.leaderboard(params[:time_period] || 'all-time')
  end
end
