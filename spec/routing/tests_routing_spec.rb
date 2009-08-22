require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TestsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "tests", :action => "index").should == "/tests"
    end

    it "maps #new" do
      route_for(:controller => "tests", :action => "new").should == "/tests/new"
    end

    it "maps #show" do
      route_for(:controller => "tests", :action => "show", :id => "1").should == "/tests/1"
    end

    it "maps #edit" do
      route_for(:controller => "tests", :action => "edit", :id => "1").should == "/tests/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "tests", :action => "create").should == {:path => "/tests", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "tests", :action => "update", :id => "1").should == {:path =>"/tests/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "tests", :action => "destroy", :id => "1").should == {:path =>"/tests/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/tests").should == {:controller => "tests", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/tests/new").should == {:controller => "tests", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/tests").should == {:controller => "tests", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/tests/1").should == {:controller => "tests", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/tests/1/edit").should == {:controller => "tests", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/tests/1").should == {:controller => "tests", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/tests/1").should == {:controller => "tests", :action => "destroy", :id => "1"}
    end
  end
end
