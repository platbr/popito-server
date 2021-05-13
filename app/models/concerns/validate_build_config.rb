# frozen_string_literal: true

module ValidateBuildConfig
  extend ActiveSupport::Concern

  included do
    validate :build_config_exclusive_keys
  end

  def build_config_exclusive_keys
    intersect = (build_config.keys & RenderContext::CLIENT_BUILD_CONFIG_EXCLUSIVE_KEYS)
    return if intersect.empty?

    errors.add(:build_config, "can't have #{intersect} keys defined on it.")
  end
end
