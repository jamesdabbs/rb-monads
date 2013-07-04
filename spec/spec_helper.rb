require 'pry'

require_relative '../lib/monad'


RSpec.configure do |config|
  # The following settings allow you to add :focus to a spec or context
  # and run only those specs
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.filter_run_excluding slow: true
  config.run_all_when_everything_filtered = true

  # Working through the examples Moore-style will cause a lot of failing
  # specs. Best not to get overwhelmed.
  config.fail_fast = true
end
