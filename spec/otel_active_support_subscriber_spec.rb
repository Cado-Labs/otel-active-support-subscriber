# frozen_string_literal: true

RSpec.describe Otel::ActiveSupportSubscriber do
  def init
    Otel::ActiveSupportSubscriber.configure do |config|
      config.subscribe_to = subscribe_to
    end
  end

  before do
    exporter.reset
  end

  let(:subscribe_to) { [/.*/] }
  let(:instrumentation) { OpenTelemetry.tracer_provider.tracer("Tracer") }
  let(:exporter) { EXPORTER }
  let(:span) { exporter.finished_spans.first }

  context "ActiveSupport::Notifications subscribers" do
    context "send fake message to subscribers" do
      let(:args) { [Time.now, Time.now, SecureRandom.hex] }
      let(:data) { { request: "REQUEST", key: "value" } }
      let(:start_args) { ["start_processing.action_controller", *args, nil] }
      let(:process_args) { ["process_action.action_controller", *args, data] }
      let(:deprecation_args) { ["!deprecation.rails", *args, nil] }

      before { init }

      specify "with span and log created" do
        instrumentation.in_span(self.class.name) do
          ActiveSupport::Notifications.publish(*start_args)
          ActiveSupport::Notifications.publish(*process_args)
          ActiveSupport::Notifications.publish(*deprecation_args)
        end
        expect(span.events.size).to eq 2
      end

      context "without span and log not created" do
        specify do
          ActiveSupport::Notifications.publish(*start_args)
          ActiveSupport::Notifications.publish(*process_args)
          ActiveSupport::Notifications.publish(*deprecation_args)
          expect(span).to eq nil
        end
      end
    end

    describe "#subscribe_to=" do
      shared_examples "subscribe to events" do
        specify do
          expect(ActiveSupport::Notifications).to receive(:monotonic_subscribe).with(/.*/)
          init
          expect(span).to eq nil
        end
      end

      shared_examples "subscribe is failed" do
        specify do
          expect(ActiveSupport::Notifications).not_to receive(:monotonic_subscribe).with(/.*/)
          init
          expect(span).to eq nil
        end
      end

      context "when string is regexp in subscribe_to elements" do
        let(:subscribe_to) { ["/.*/"] }

        include_examples "subscribe to events"
      end

      context "when string is not regexp and start with /" do
        let(:subscribe_to) { [".*/"] }

        include_examples "subscribe to events"
      end

      context "when subscribe_to is blank" do
        let(:subscribe_to) { [] }

        include_examples "subscribe is failed"
      end

      context "when subscribe_to is [1]" do
        let(:subscribe_to) { [1] }

        include_examples "subscribe is failed"
      end
    end
  end
end
