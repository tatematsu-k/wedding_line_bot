# frozen_string_literal: true

class LineClient
  def self.build
    new
  end

  def method_missing(m, *arg, **kw, &block)
    Rails.logger.info("call `#{m}` with #{arg} #{kw}")
    line_bot_client.public_send(m, *arg, **kw, &block).tap do |res|
      Rails.logger.info(res)
      if res.is_a? Net::HTTPResponse
        Rails.logger.info(res.body)
      end
    end
  end

  def line_bot_client
    self.class.line_bot_client
  end

  def self.line_bot_client
    Rails.logger.info("get line bot client")
    @@client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end
  end
end
