# frozen_string_literal: true

module Patcher
  class AppendIfNotFound < Patcher::Base
    def patched_content
      if content.match?(Regexp.new(file_patch.search_regex))
        content
      else
        newline = file_patch.newline_on_append ? file_patch.newline_char : ''
        content + newline + file_patch.replace
      end
    end
  end
end
