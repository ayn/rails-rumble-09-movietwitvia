require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Question do
  before(:each) do
    @valid_attributes = {
      :imdb_id => ,
      :title => "value for title",
      :actors => "value for actors",
      :tweet_id => 
    }
  end

  it "should create a new instance given valid attributes" do
    Question.create!(@valid_attributes)
  end
end
