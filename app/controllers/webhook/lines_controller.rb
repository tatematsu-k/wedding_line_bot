# frozen_string_literal: true

module Webhook
  class LinesController < ApplicationController
    def create
      render json: { state: :ok }
    end
  end
end
