# frozen_string_literal: true

module Otel
  module ActiveSupportSubscriber
    class Init
      class << self
        def call
          activate_subscribers
        end

        private

        def activate_subscribers
          events = config.subscribe_to
          return if events.blank?

          events.each do |event|
            Otel::ActiveSupportSubscriber::Subscriber.subscribe_to_event!(event)
          end
        end

        def config
          Otel::ActiveSupportSubscriber.config
        end
      end
    end
  end
end
