# frozen_string_literal: true

module FileResource
  class DeployingModel < FileResource::File
    include HasEmptyPath
    has_many :deploying_resources
  end
end
