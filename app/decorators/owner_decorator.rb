class OwnerDecorator < Draper::Decorator
  delegate_all

  def name
    "#{model.class.name}: " + model.name
  end
end
