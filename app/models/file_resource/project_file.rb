# frozen_string_literal: true

module FileResource
  class ProjectFile < FileResource::File
    validates :path, presence: true
    validates :owner_id, presence: true
  end
end
