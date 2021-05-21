# frozen_string_literal: true

module FileResource
  class ProjectFile < FileResource::File
    def needs_label?
      false
    end

    def needs_path?
      true
    end

    def needs_owner?
      true
    end

    # def self.exportable_search_attributes
    #   [:name]
    # end
  end
end
