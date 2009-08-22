require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/questions/show.html.erb" do
  include QuestionsHelper
  before(:each) do
    assigns[:question] = @question = stub_model(Question,
      :imdb_id => ,
      :title => "value for title",
      :actors => "value for actors",
      :tweet_id => 
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(//)
    response.should have_text(/value\ for\ title/)
    response.should have_text(/value\ for\ actors/)
    response.should have_text(//)
  end
end
