require (File.expand_path('./../../spec_helper', __FILE__))

describe Redcukes::Redmine do

 it "should have default attributes" do
    Redcukes::Redmine.format.should == ActiveResource::Formats::XmlFormat
 end

 it "should respond to search filter attribute" do
    Redcukes::Redmine.should be_respond_to :search_filter
 end
 
 it "should have empty search filter by default" do
    Redcukes::Redmine.search_filter.should == {}	
 end

 it "should have default result status" do
    Redcukes::Redmine.result_status.should == {:passed => 3,:failed => 6}
 end
 
 context "redmine configuration" do

    it "should respond to configure" do
      Redcukes::Redmine.should be_respond_to :configure
    end

    it "should be able to configure attributes" do
      Redcukes::Redmine.configure do |c|
        c.user= "user"
		c.result_status = {:passed => 7,:failed => 9}
      end
      Redcukes::Redmine.user.should == "user"
	  Redcukes::Redmine.result_status.should == {:passed => 7,:failed => 9}
      Redcukes::Redmine.password.should be_nil
    end
    
 end
 
end