# frozen_string_literal: true

module HasOwner
  extend ActiveSupport::Concern

  included do
    belongs_to :owner, polymorphic: true, optional: true
    before_validation :set_owner_priority
    validates :owner_priority, presence: true
  end

  def set_owner_priority
    # The idea here is to make possible project's object became last to override others.
    # To archive this, just use '.or()' and order(:owner_priority)
    self.owner_priority = 100 if owner.is_a?(Project)
    self.owner_priority = 50 if owner.is_a?(Template)
    self.owner_priority = 10 if owner.is_a?(NilClass)
  end
end
