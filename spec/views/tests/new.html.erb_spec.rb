require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tests/new.html.erb" do
  include TestsHelper

  before(:each) do
    assigns[:test] = stub_model(Test,
      :new_record? => true
    )
  end

  it "renders new test form" do
    render

    response.should have_tag("form[action=?][method=post]", tests_path) do
    end
  end
end
