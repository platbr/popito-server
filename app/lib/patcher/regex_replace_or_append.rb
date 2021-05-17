# frozen_string_literal: true

module Patcher
  class RegexReplaceOrAppend < Patcher::Base
    def patched_content
      search_regex = Regexp.new(file_patch.search_regex)
      if content.match?(search_regex)
        content.gsub(search_regex, file_patch.replace)
      else
        newline = file_patch.newline_on_append ? file_patch.newline_char : ''
        content + newline + file_patch.replace
      end
    end
  end
end
