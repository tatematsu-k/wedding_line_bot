# frozen_string_literal: true

require "rails_helper"

describe Webhook::LinesController do
  describe "POST /webhook/line" do
    include_context :line_requestable

    subject { post webhook_line_path, params:, as: :json }

    let!(:params) do
      {
        destination: "sampleDestination",
        events: [event],
        line: {
          destination: "sampleDestination",
          events: [event]
        }
      }
    end

    context "with message event" do
      let!(:event) do
        {
          type: "message",
          message: {
            type: "text",
            id: "123456789",
            text: "ほげ"
          },
          timestamp: 1645876173427,
          source: {
            type: "user",
            userId: "sampleUserId"
          },
          replyToken: "sampleReplyToken",
          mode: "active"
        }
      end

      it { is_expected.to eq 200 }

      specify do
        subject

        expect(line_client).to have_received(:reply_message).once
      end
    end

    context "with invalid signature" do
      let!(:event) { nil }
      let!(:validate_signature_response) { false }

      it { is_expected.to eq 400 }
    end
  end
end
