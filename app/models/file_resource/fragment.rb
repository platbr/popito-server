# frozen_string_literal: true

module FileResource
  class Fragment < FileResource::File
    include HasEmptyPath
    validates :owner_id, inclusion: { in: [nil], message: 'must be blank'}
  end
end
