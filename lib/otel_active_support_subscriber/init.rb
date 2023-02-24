# frozen_string_literal: true

module OtelActiveSupportSubscriber
  class Init
    class << self
      def call
        activate_subscribers
      end

      private

      def activate_subscribers
        events = config.subscribe_to
        return if events.blank?

        events.each { |event| OtelActiveSupportSubscriber::Subscriber.subscribe_to_event!(event) }
      end

      def config
        OtelActiveSupportSubscriber.config
      end
    end
  end
end
