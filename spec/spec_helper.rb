require "bundler/setup"
require "graped_moviez"
require "factory_bot"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.include FactoryBot::Syntax::Methods

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.before(:suite) do
    # GrapedMoviez::Configuration.config.db_url = 'postgres://postgres@localhost:5433/graped_moviez_test'
    # GrapedMoviez::Configuration.config.env = :test
    FactoryBot.find_definitions
  end
end
