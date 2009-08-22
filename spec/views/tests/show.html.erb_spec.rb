require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tests/show.html.erb" do
  include TestsHelper
  before(:each) do
    assigns[:test] = @test = stub_model(Test)
  end

  it "renders attributes in <p>" do
    render
  end
end
