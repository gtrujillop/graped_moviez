require "bundler/setup"
require "graped_moviez"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.before(:all) do
    GrapedMoviez.configure do |conf|
      conf.db_url = 'postgres://postgres@localhost:5433/graped_moviez_test'
    end
  end
end
