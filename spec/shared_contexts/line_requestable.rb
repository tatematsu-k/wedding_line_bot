# frozen_string_literal: true

require "rails_helper"

shared_context :line_requestable do
  let!(:line_client) { Line::Bot::Client.new }
  let!(:validate_signature_response) { true }

  before do
    allow(LineClient).to receive(:build).and_return(line_client)
    allow(line_client).to receive(:validate_signature).and_return(validate_signature_response)
    allow(line_client).to receive(:reply_message).and_return(Net::HTTPResponse.new(nil, "200", "OK"))
    allow(line_client).to receive(:push_message).and_return(Net::HTTPResponse.new(nil, "200", "OK"))
  end
end
