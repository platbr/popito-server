# frozen_string_literal: true

module FileResource
  class DeployingFile < FileResource::File
    validates :path, presence: true
  end
end
