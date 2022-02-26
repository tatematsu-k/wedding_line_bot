# frozen_string_literal: true

module Webhook
  class LinesController < ApplicationController
    def create
      Line::RequestHandleService.new(
        signature: request.env["HTTP_X_LINE_SIGNATURE"],
        body: request.body.read,
      ).call

      render json: { state: :ok }
    rescue Line::RequestHandleService::SIGNATURE_ERROR
      render json: { reason: "signature is invalid." }, status: 400
    end
  end
end
