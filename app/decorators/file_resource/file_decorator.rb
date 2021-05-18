module FileResource
  class FileDecorator < Draper::Decorator
    delegate_all
    decorates_association :owner

    # def owner
    #   return "Global" if object.owner.nil?
    #   OwnerDecorator.new(object.owner)
    # end
  end
end
