require 'bundler/setup'
require 'pry'
require 'faker'
require 'slack_fetch_diff'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
Dir['./spec/shared_context/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
