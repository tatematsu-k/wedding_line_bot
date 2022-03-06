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

    context "with follow event" do
      let!(:event) do
        {
          type: "follow",
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

      it { expect { subject }.to change(LineUser, :count).by(1) }
    end

    context "with unfollow event" do
      let!(:event) do
        {
          type: "unfollow",
          timestamp: 1645876173427,
          source: {
            type: "user",
            userId: line_user.line_uid
          },
          replyToken: "sampleReplyToken",
          mode: "active"
        }
      end
      let!(:line_user) { create(:line_user, line_uid: "sampleUserId") }

      it { is_expected.to eq 200 }
      it { expect { subject }.to change { line_user.reload.follow_status }.from("follow").to("unfollow") }
    end

    context "with postback event" do
      let!(:event) do
        {
          type: "postback",
          postback: {
            data: "service=name_confirm&invited_user_id=#{invited_user.id}&cmd=no"
          },
          timestamp: 1645876173427,
          source: {
            type: "user",
            userId: line_user.line_uid
          },
          mode: "active"
        }
      end
      let!(:invited_user) { create(:invited_user) }
      let!(:line_user) { create(:line_user, line_uid: "sampleUserId") }

      it { is_expected.to eq 200 }
    end

    context "with invalid signature" do
      let!(:event) { nil }
      let!(:validate_signature_response) { false }

      it { is_expected.to eq 400 }
    end
  end
end
