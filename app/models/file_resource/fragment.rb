# frozen_string_literal: true

module FileResource
  class Fragment < FileResource::File
    def needs_label?
      true
    end

    def needs_path?
      false
    end

    def needs_owner?
      false
    end

    def exportable_search_attributes
      [:label]
    end
  end
end
