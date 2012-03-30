require 'active_resource'

module Redcukes

  class Redmine < ActiveResource::Base
    @@result = nil
    @@search_content = nil
    self.format = :xml

    def self.result_status=(value)
      @@result = value
    end

    def self.result_status
      @@result || {:passed => 3,:failed => 6}
    end

    def self.search_filter=(value)
      @@search_content = value
    end

    def self.search_filter
      @@search_content || {}
    end

    def self.configure &block
      block.call(self)
    end
  end

end