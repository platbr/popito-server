# frozen_string_literal: true

module CustomSanitizer
  def should_be(name, object, klass)
    return if object.is_a?(klass)

    raise ArgumentError, "The #{name} param should be a #{klass.name} instance instead of #{object.class.name}."
  end
end
