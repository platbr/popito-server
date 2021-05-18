class DeployingResourceDecorator < Draper::Decorator
  delegate_all
  decorates_association :owner
end
