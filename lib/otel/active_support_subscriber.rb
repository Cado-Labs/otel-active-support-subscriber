# frozen_string_literal: true

require "active_support"
require_relative "active_support_subscriber/config"

module Otel
  module ActiveSupportSubscriber
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
end

require_relative "active_support_subscriber/init"
require_relative "active_support_subscriber/subscriber"
