class Environment < ApplicationRecord
  include ValidateBuildConfig
  belongs_to :project
end
