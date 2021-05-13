# frozen_string_literal: true

module Patcher
  class Base
    include CustomSanitizer

    attr_accessor :file_patch, :content

    def initialize(file_patch:, content:)
      should_be('file_patch', file_patch, FilePatch)
      self.file_patch = file_patch
      self.content = content
    end

    def patched_content
      raise NotImplementedError, 'The Patcher must implement patched_content method.'
    end
  end
end
