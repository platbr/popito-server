class Environment < ApplicationRecord
  include ValidateBuildConfig
  belongs_to :project
  
  alias_attribute :name, :label

  validates :label, presence: true

  amoeba do
    enable
  end
end
