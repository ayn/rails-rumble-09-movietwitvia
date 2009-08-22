require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/questions/index.html.erb" do
  include QuestionsHelper

  before(:each) do
    assigns[:questions] = [
      stub_model(Question,
        :imdb_id => ,
        :title => "value for title",
        :actors => "value for actors",
        :tweet_id => 
      ),
      stub_model(Question,
        :imdb_id => ,
        :title => "value for title",
        :actors => "value for actors",
        :tweet_id => 
      )
    ]
  end

  it "renders a list of questions" do
    render
    response.should have_tag("tr>td", .to_s, 2)
    response.should have_tag("tr>td", "value for title".to_s, 2)
    response.should have_tag("tr>td", "value for actors".to_s, 2)
    response.should have_tag("tr>td", .to_s, 2)
  end
end
