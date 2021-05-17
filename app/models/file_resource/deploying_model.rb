# frozen_string_literal: true

module FileResource
  class DeployingModel < FileResource::File
    include HasEmptyPath
    has_many :deploying_resources
    validates :owner_id, inclusion: { in: [nil], message: 'must be blank'}
  end
end
