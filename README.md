# Active support subscriber for Opentelemetry 
# &middot; <a target="_blank" href="https://github.com/Cado-Labs"><img src="https://github.com/Cado-Labs/cado-labs-logos/raw/main/cado_labs_badge.svg" alt="Supported by Cado Labs" style="max-width: 100%; height: 20px"></a> &middot; [![Coverage Status](https://coveralls.io/repos/github/Cado-Labs/otel-active-support-subscriber/badge.svg?branch=master)](https://coveralls.io/github/Cado-Labs/otel-active-support-subscriber?branch=master)

Helper for the gem "opentelemetry-ruby". Subscribe to active support events and add context active support events to current span.

---

<p>
  <a href="https://github.com/Cado-Labs">
    <img src="https://github.com/Cado-Labs/cado-labs-resources/blob/main/cado_labs_supporting_rounded.svg" alt="Supported by Cado Labs" />
  </a>
</p>

---

## Installation

```ruby
# --- from GitHub ---
gem 'otel-active-support-subscriber', github: "Cado-Labs/otel-active-support-subscriber"
# --- or ---
gem 'otel-active-support-subscriber'
```

```shell
bundle install
# --- or ---
gem install otel-active-support-subscriber
```

```ruby
require 'otel/active-support-subscriber'
```

## Usage

```ruby
::Otel::ActiveSupportSubscriber.configure do |config|
  config.subscribe_to = [/.*/, "/sql/", "sql.sequel"]
end
```
* Array elements starting and ending with "/" are converted to a regular expression

### Contributing

 - Fork it ( https://github.com/Cado-Labs/otel-active-support-subscriber )
 - Create your feature branch (`git checkout -b feature/my-new-feature`)
 - Commit your changes (`git commit -am '[feature_context] Add some feature'`)
 - Push to the branch (`git push origin feature/my-new-feature`)
 - Create new Pull Request

## License

Released under MIT License.

## Supporting

<a href="https://github.com/Cado-Labs">
  <img src="https://github.com/Cado-Labs/cado-labs-resources/blob/main/cado_labs_supporting_rounded.svg" alt="Supported by Cado Labs" />
</a>

## Authors

[Aleksandr Starovojtov](https://github.com/AS-AlStar)
