module Redcukes
  class FeatureReport
    def initialize(step_mother, io, options)
      @status = {}
    end

    def before_feature feature
      @status[:errors] = @status[:undefined] = @status[:failed] = @status[:passed]= 0
    end

    def after_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background, file_colon_line)
      @status[status] += 1 if @status.has_key? status
    end

    def after_feature feature
      id = feature.file.scan(/(\d+)/).flatten[0].to_i
      Issue.update_status id, @status
    end
  end
end
