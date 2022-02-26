# frozen_string_literal: true

require "rails_helper"

describe Webhook::LinesController do
  describe "POST /webhook/line" do
    subject { post webhook_line_path }

    it { is_expected.to eq 200 }
  end
end
