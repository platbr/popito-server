ActiveAdmin.register FileResource::BuildingFile, as: "BuildingFile" do
  menu parent: "Files"
  include AdminFileConcern
end
