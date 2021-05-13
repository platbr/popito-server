# frozen_string_literal: true

module FileResource
  class DeployingFile < FileResource::Base
    validates :path, presence: true
  end
end
