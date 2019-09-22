require 'dry-configurable'
require "dry/configurable/test_interface"

module GrapedMoviez
  class Configuration
    extend Dry::Configurable
    
    setting :db_url, ENV['DATABASE_URL']
    setting :env, :development
  end
end
