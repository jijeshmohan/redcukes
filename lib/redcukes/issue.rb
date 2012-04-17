module Redcukes
  class Issue < Redmine

    @@default_filter = {:status_id => '*'}

    class << self
      # Get all redmine issues with a specified search criteria
      def cucumber_features
        filter = @default_filter.merge(self.search_filter)
        find(:all, :params => filter)
      end

      # Update redmine issue status.
      def update_status(id, status={})
        s = Issue.find(id)
        return if s.nil?
        if (status[:failed] != 0 || status[:errors] != 0)
          s.status_id = self.result_status[:failed]
        else
          s.status_id = self.result_status[:passed] if status[:passed] > 0
        end
        s.save
      end
    end
  end
end

