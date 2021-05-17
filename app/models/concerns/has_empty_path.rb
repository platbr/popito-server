# frozen_string_literal: true

module HasEmptyPath
  extend ActiveSupport::Concern

  included do
    validates :label, presence: true
    validate :check_empty_path
  end

  def check_empty_path
    return if path.blank?
  
    errors.add(:path, "must to be blank for a #{self.class}")
  end
end
