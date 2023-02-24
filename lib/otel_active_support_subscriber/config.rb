# frozen_string_literal: true

module OtelActiveSupportSubscriber
  class Config
    def subscribe_to
      @subscribe_to ||= []
    end

    def subscribe_to=(events)
      @subscribe_to = Array(events).flat_map do |e|
        case
        when e.is_a?(Regexp) then e
        when !e.is_a?(String)
        when e[0] == "/" && e[-1] == "/" then Regexp.new(e[1...-1])
        else
          e.to_s
        end
      end
    end
  end
end
