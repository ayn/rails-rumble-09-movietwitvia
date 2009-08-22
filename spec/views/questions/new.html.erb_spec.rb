require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/questions/new.html.erb" do
  include QuestionsHelper

  before(:each) do
    assigns[:question] = stub_model(Question,
      :new_record? => true,
      :imdb_id => ,
      :title => "value for title",
      :actors => "value for actors",
      :tweet_id => 
    )
  end

  it "renders new question form" do
    render

    response.should have_tag("form[action=?][method=post]", questions_path) do
      with_tag("input#question_imdb_id[name=?]", "question[imdb_id]")
      with_tag("input#question_title[name=?]", "question[title]")
      with_tag("input#question_actors[name=?]", "question[actors]")
      with_tag("input#question_tweet_id[name=?]", "question[tweet_id]")
    end
  end
end
