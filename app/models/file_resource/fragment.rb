# frozen_string_literal: true

module FileResource
  class Fragment < FileResource::Base
    validates :label, presence: true
    validate :path_empty

    def path_empty
      return if path.nil?

      errors.add(:path, "must to be nil for a #{self.class}")
    end
  end
end
