ActiveAdmin.register FileResource::DeployingModel, as: "DeployingModel" do
  menu parent: "Models"
  include AdminFileConcern
end
