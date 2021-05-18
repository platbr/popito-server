ActiveAdmin.register FileResource::DeployingFile, as: "DeployingFile" do
  menu parent: "Files"
  include AdminFileConcern
end
