require 'support.rb'
class Cucumber::Runtime
  alias cucumber_features features

  def features
    filters = []
    features = Cucumber::Ast::Features.new
    issues = Redcukes::Issue.cucumber_features
    issues.each do |s|
      uri = "#{s.id}.feature"
      # clean up redmine text formatting
      description = s.description.gsub(/<\/?code[^>]*>/ui,'').gsub(/<\/?pre[^>]*>/ui,'"""')
      subject = "Feature: #{s.subject}\n"

      source = "#{get_tags s}#{subject}\n #{description}\n"
      feature_file = Cucumber::FeatureFile.new(uri, source)
      write_to_local uri, source
      feature = feature_file.parse(filters, {}) rescue nil
      features.add_feature(feature) if feature
    end
    features
  end

  def get_tags(issue)
    tags = ''
    issue.custom_fields.each do |field|
      tags = field.value.join(' ') + "\n" if field.name = 'Tag'
    end
    tags
  end

  def write_to_local(feature_file, feature_content)
    begin
      file = File.open("#{Rails.root}/features/#{feature_file}", 'w')
      file.write(feature_content)
    rescue IOError => e
      # some error occur, dir not writable etc.
      p e
    ensure
      file.close unless file == nil
    end
  end
end

# this is deprecated
# AfterConfiguration do |config|
#  config.formats << ['Redcukes::FeatureReport', config.out_stream]
# end
