# frozen_string_literal: true

module FileResource
  class ProjectFile < FileResource::File
    validates :path, presence: true
  end
end
