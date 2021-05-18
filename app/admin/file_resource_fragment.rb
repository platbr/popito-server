ActiveAdmin.register FileResource::Fragment, as: "Fragment" do
  menu parent: "Models"
  include AdminFileConcern
end
