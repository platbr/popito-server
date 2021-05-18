# frozen_string_literal: true

module FixOwnerOnDuplicate
  extend ActiveSupport::Concern

  included do
    before_validation :fix_owner_on_duplicate
  end

  def fix_owner_on_duplicate
    self.owner_id ||= 0 if owner.present? && owner.id.nil?
  end
end
