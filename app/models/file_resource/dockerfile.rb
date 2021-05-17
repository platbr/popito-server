# frozen_string_literal: true

module FileResource
  class Dockerfile < FileResource::File
    validates :path, presence: true
    validates :label, presence: true
    validates :owner_id, presence: true
    private

    def turn_on_comments
      true
    end
  end
end
