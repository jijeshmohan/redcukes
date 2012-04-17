require 'active_resource'

module Redcukes
    
  # Redmine is the main configuration base class to access redmine application 
  class Redmine < ActiveResource::Base
  
    # active resource format set to xml for calling redmine REST service
    self.format = :xml
    
    class << self
        # To set result status update back to redmine.
        # The value should be a has contains :passed and :failed status ids in the redmine
        def result_status=(value)
            @result = value
        end

        # To get result status update back to redmine
        # if there is no result status specified, this will be defaulted to  {:passed => 3,:failed => 6}
        # this means in redmine the issue status will be set to “Resolved” if passed and set to “Rejected” if failed.
        def result_status
            @result || {:passed => 3,:failed => 6}
        end
        
        # To set issue search filter in redmine, possible filter are 
        # 
        # :project_id, :tracker_id, :status_id
        def search_filter=(value)
            @search_content = value
        end
        
        # To get the issue search filter for fetcting issues from redmine.
        def search_filter
            @search_content || {}
        end

        # To configure redmine settings via cucumber env file
        def configure &block
            block.call(self)
        end
    end
    
  end
end