# frozen_string_literal: true

require "active_support"
require_relative "otel_active_support_subscriber/config"

module OtelActiveSupportSubscriber
  class << self
    def config
      @config ||= Config.new
    end

    def configure
      yield config
      Init.call
    end
  end
end

require_relative "otel_active_support_subscriber/init"
require_relative "otel_active_support_subscriber/subscriber"
