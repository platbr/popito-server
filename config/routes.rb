# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "admin/dashboard#index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1 do
      get '/included-files', to: 'archive#included_files_list', format: false
      post '/archive', to: 'archive#create', format: false
    end
  end
end
