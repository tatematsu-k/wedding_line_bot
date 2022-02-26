Rails.application.routes.draw do
  namespace :webhook do
    resource :line, only: [:create]
  end
end
