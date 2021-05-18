class FilePatchDecorator < Draper::Decorator
  delegate_all
  decorates_association :owner
end
