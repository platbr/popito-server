class Environment < ApplicationRecord
  include ValidateBuildConfig
  belongs_to :project
  
  alias_attribute :name, :label

  amoeba do
    enable
  end
end
