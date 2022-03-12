# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :webhook do
    resource :line, only: [:create]
  end

  get "healthcheck", to: proc { [200, {}, [""]] }
end
