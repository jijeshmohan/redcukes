require 'support.rb'
class Cucumber::Runtime
  alias cucumber_features features

  def features
    filters = []
    features = Cucumber::Ast::Features.new
    issues = Redcukes::Issue.cucumber_features
    issues.each do |s|
      feature_file = Cucumber::FeatureFile.new("#{s.id}.feature", "Feature: #{s.subject}\n #{s.description}\n")
      feature = feature_file.parse(filters, {}) rescue nil
      features.add_feature(feature) if feature
    end
    features
  end
end


AfterConfiguration do |config|
  config.formats << ['Redcukes::FeatureReport', config.out_stream]
end
