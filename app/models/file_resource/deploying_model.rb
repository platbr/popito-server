# frozen_string_literal: true

module FileResource
  class DeployingModel < FileResource::File
    has_many :deploying_resources

    def needs_label?
      true
    end

    def needs_path?
      false
    end

    def needs_owner?
      false
    end

    def needs_owner?
      false
    end
  end
end
