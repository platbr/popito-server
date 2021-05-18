ActiveAdmin.register FileResource::Dockerfile, as: "Dockerfile" do
  menu parent: "Files"
  include AdminFileConcern
end
