require (File.expand_path('./../../spec_helper', __FILE__))

describe Redcukes::Redmine do

  it "should have default attributes" do
    Redcukes::Redmine.format.should == ActiveResource::Formats::XmlFormat
  end

  it "should respond to search filter attribute" do
    Redcukes::Redmine.should be_respond_to :search_filter
  end

  context "redmine configuration" do

    it "should respond to configure" do
      Redcukes::Redmine.should be_respond_to :configure
    end

    it "should be able to configure attributes" do
      Redcukes::Redmine.configure do |c|
        c.user= "user"
      end
      Redcukes::Redmine.user.should == "user"
      Redcukes::Redmine.password.should be_nil
    end

  end
end