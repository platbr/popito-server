class AdminOwnerHelper
  # TODO: create a way to disable projects and templates.
  # TODO: optimize queries
  def self.all_owners
    OwnerDecorator.decorate_collection(Template.all.order(:name) + Project.all.order(:name))
  end
end
