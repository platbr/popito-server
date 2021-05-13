# frozen_string_literal: true

class FilePatch < ApplicationRecord
  include CustomSanitizer
  include HasOwner

  enum kind: { regex_replace: 0, regex_replace_or_append: 1, append_if_not_found: 2 }, _prefix: :kind
end
