# frozen_string_literal: true

module Patcher
  class RegexReplace < Patcher::Base
    def patched_content
      content.gsub(Regexp.new(file_patch.search_regex), file_patch.replace)
    end
  end
end
