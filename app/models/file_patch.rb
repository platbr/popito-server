# frozen_string_literal: true

class FilePatch < ApplicationRecord
  include CustomSanitizer
  include HasOwner
  include HasNewLine

  enum kind: { regex_replace: 0, regex_replace_or_append: 1, append_if_not_found: 2 }, _prefix: :kind
  validates :owner, presence: true
  validates :name, presence: true
  validates :kind, presence: true
  validates :path, presence: true
  validates :search_regex, presence: true
  validates :order, presence: true

  amoeba do
    enable
  end
end
