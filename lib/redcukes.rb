require 'support.rb'
# Extends cucumber to read features from redmine and write them to local files
class Cucumber::Cli::Configuration
  alias_method :original_feature_files, :feature_files
  # override parent method
  # you can define a "custom field" in redmine named "Tags" to add tags to your feature files
  def feature_files
    features = Redcukes::Issue.cucumber_features
    features.each do |feature|
      @tags = get_tags feature
      write_feature_file(build_feature_filename(feature), build_source(feature)) if is_valid?(feature)
    end
    # proceed as usual
    original_feature_files
  end

  # Check if the feature is valid
  # It must have at least a description
  def is_valid?(feature)
    !feature.description.blank?
  end

  # builds the path and filename to the feature
  # for now, just cucumberjs tagged features go into a separate dir
  def build_feature_filename(feature)
    features_subdir = "#{Rails.root}/#{get_tag_dir}"
    Dir.mkdir features_subdir unless Dir.exists?(features_subdir)
    "#{features_subdir}#{feature.id}_#{feature.subject.parameterize}.feature"
  end

  def get_tag_dir
    has_tag('cucumberjs') ? 'features_js/' : 'features/'
  end

  # checks if a given tag is in the feature
  def has_tag(tag)
    @tags.include?("@#{tag}")
  end

  # creates the feature file
  def build_source(feature)
    # clean up redmine text formatting
    description = feature.description.gsub(/<\/?code[^>]*>/ui,'').gsub(/<\/?pre[^>]*>/ui,'"""').gsub(/^$\n/, '')
    subject = "Feature: #{feature.subject}\n"
    "#{@tags.join(' ') + "\n" if @tags}#{subject}\n #{description}\n"
  end

  # Gets the tags from the custom field
  def get_tags(feature)
    tags = []
    feature.custom_fields.each { |field| tags = field.value if field.name = 'Tag' }
    tags
  end

  # Writes the created feature file to filesystem
  def write_feature_file(feature_file, feature_content)
    begin
      file = File.open(feature_file, 'w')
      file.write(feature_content)
    rescue IOError => e
      # some error occur, dir not writable etc.
      pp e
    ensure
      file.close unless file == nil
    end
  end
end
