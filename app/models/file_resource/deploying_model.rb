# frozen_string_literal: true

module FileResource
  class DeployingModel < FileResource::File
    has_many :deploying_resources, dependent: :restrict_with_error

    def needs_label?
      true
    end

    def needs_path?
      false
    end

    def needs_owner?
      false
    end

    def self.exportable_search_attributes
      [:label]
    end
  end
end
