ActiveAdmin.register FileResource::ProjectFile, as: "ProjectFile" do
  menu parent: "Files"
  include AdminFileConcern
end
