class StaticController < ApplicationController
  def index
    @users = User.all(:order => "created_at DESC", :limit => 16)
    @leaders = User.leaderboard(params[:time_period] || 'all-time')
    @question = Question.next_random_question
  end

  def mentions
    all_mentions = Rails.cache.fetch("all_mentions", :expires_in => 30.seconds) do
      existing_mentions = Rails.cache.read('existing_mentions') || []
      # me = Rails.cache.fetch('twitvia_twitter_user') { User.find_by_twitter_id('67771125') }
      me = User.find_by_twitter_id('67771125')
      since_id = Rails.cache.read('since_id') || 0
      req = "/statuses/mentions.json"
      req += "?since_id=#{since_id}" if since_id != 0
      mentions_since_last_fetch = Rails.cache.fetch('twitvia_twitter_user') { User.find_by_twitter_id('67771125') }.twitter.get(req)
      last_100_mentions = ( mentions_since_last_fetch + existing_mentions ).last(100)
      Rails.cache.write('since_id', last_100_mentions.first['id'])
      Rails.cache.write('existing_mentions', last_100_mentions)
      last_100_mentions
    end
    
    logger.debug { "all_mentions is #{all_mentions.inspect}" }
    logger.debug { "browser_since_id is #{session[:browser_since_id].to_i}" }

    unless (browser_since_id = session[:browser_since_id].to_i) == 0 || params[:new_page_load].to_i == 1
      @mentions = []
      
      all_mentions.each do |m|
        if m['id'].to_i > browser_since_id.to_i
          logger.debug { "m.id = #{m['id']}, browser_since_id = #{browser_since_id}" }
          @mentions << m
        else
          break
        end
      end
    else
      @mentions = all_mentions
    end
    
    session[:browser_since_id] = @mentions.first['id'] unless @mentions.empty?
    
    logger.debug { "mentions are #{@mentions.inspect}" }
    render :action => 'mentions', :layout => false
  end
  
  def reset_session
    session[:browser_since_id] = nil
    render :text => 'session reset'
  end
end