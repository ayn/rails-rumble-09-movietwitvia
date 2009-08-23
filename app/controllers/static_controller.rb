class StaticController < ApplicationController
  def index
    @title = 'Play Movie Trivia on Twitter!'
    @users = User.all(:order => "created_at DESC", :limit => 16)
    @leaders = User.leaderboard(params[:time_period] || 'all-time') 
    @question = Question.next_random_question
    @text = session[:text]
    @in_reply_to_status_id = session[:in_reply_to_status_id]
    flash.now[:notice] = "Thanks for logging in, please send your answer again!" if @text && @in_reply_to_status_id
    session[:text] = session[:in_reply_to_status_id] = nil
  end
  
  def current_question
    @question = Question.next_random_question
    render :text => @question.get_question
  end

  def mentions
    all_mentions = Rails.cache.fetch("all_mentions", :expires_in => 30.seconds) do
      existing_mentions = Rails.cache.read('existing_mentions') || []
      since_id = Rails.cache.read('since_id') || 0
      req = "/statuses/mentions.json"
      req += "?since_id=#{since_id}" if since_id != 0
      mentions_since_last_fetch = User.find_by_twitter_id('67771125').twitter.get(req) || []
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
  
  def reply
    if current_user
      if params[:text] && params[:in_reply_to_status_id]
        current_user.twitter.post('/statuses/update.json', 'status' => params[:text], 'in_reply_to_status_id' => params[:in_reply_to_status_id])
        @notice = %Q{<div class='flash notice'>Answer tweeted! Thank you!</div>}
        session[:text], session[:in_reply_to_status_id] = nil
      else
        @notice = %Q{<div class='flash error'>Sorry,there was a problem tweeting your answer, please try again!</div>}
      end
      
      render :update do |page|
        page.insert_html :bottom, '#flash_wrap', @notice
        page << %Q{$('#text').val('.@MovieTwitvia ');}
        page.call 'fadeNotice()'
      end
    else
      session[:text], session[:in_reply_to_status_id] = params[:text], params[:in_reply_to_status_id]
      
      render :update do |page|
        page.redirect_to(:action => 'login')
      end
    end
  end
end