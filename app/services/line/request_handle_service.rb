# frozen_string_literal: true

module Line
  class RequestHandleService
    SIGNATURE_ERROR = Class.new(StandardError)

    attr_reader :body, :signature

    def initialize(body:, signature:)
      @body = body
      @signature = signature
    end

    def call
      validate_signature!

      events.each do |event|
        EventHandleService.new(event:).call
      end

      true
    end

    private
      def validate_signature!
        return if client.validate_signature(body, signature)

        raise SIGNATURE_ERROR
      end

      def events
        client.parse_events_from(body)
      end

      def client
        @client ||= LineClient.build
      end
  end
end
