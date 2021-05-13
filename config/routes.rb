# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/included-files', to: 'archive#included_files_list', format: false
      post '/archive', to: 'archive#create', format: false
    end
  end
end
