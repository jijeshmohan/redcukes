require (File.expand_path('./../../spec_helper', __FILE__))

describe Redcukes::Issue do

  it "should respond to active resource attributes" do
    Redcukes::Issue.should be_respond_to :find
  end
  
  it "should respond to cucumber_features" do
    Redcukes::Issue.should be_respond_to :cucumber_features
  end
  
end