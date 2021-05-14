# frozen_string_literal: true

module HasEmptyPath
  extend ActiveSupport::Concern

  included do
    validates :label, presence: true
    validate :check_empty_path
  end

  def check_empty_path
    return if path.nil?
  
    errors.add(:path, "must to be nil for a #{self.class}")
  end
end
