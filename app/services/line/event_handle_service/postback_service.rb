# frozen_string_literal: true

module Line
  class EventHandleService::PostbackService
    attr_reader :event, :line_user

    def initialize(event:, line_user:)
      @event = event
      @line_user = line_user
    end

    def call
      service.call
    end

    private
      def service
        service_class.new(event:, line_user:, **data.delete_if { |k, _| k == :service })
      end

      def service_class
        self.class.const_get("#{data[:service].camelize}Service")
      end

      def data
        @data ||= URI.decode_www_form(event["postback"]["data"]).to_h.deep_symbolize_keys
      end
  end
end
