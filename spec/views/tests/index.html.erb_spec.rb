require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tests/index.html.erb" do
  include TestsHelper

  before(:each) do
    assigns[:tests] = [
      stub_model(Test),
      stub_model(Test)
    ]
  end

  it "renders a list of tests" do
    render
  end
end
