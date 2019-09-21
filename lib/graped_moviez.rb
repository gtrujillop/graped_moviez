require 'sequel'
require_all 'graped_moviez/db'
require "graped_moviez/configuration"
require "graped_moviez/version"
require "graped_moviez/db_config"
require "graped_moviez/api/v1/movies"
require "graped_moviez/api/v1/reservations"
require "graped_movies/models/movie"
require "graped_movies/models/reservation"
require "graped_movies/models/user"

module GrapedMoviez
  class << self
    attr_accessor :configuration
  end

  def self.configuration 
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
  
  class Error < StandardError; end
  # Your code goes here...
end

GrapedMoviez.configure do |conf|      
  conf.db_url = ENV['DATABASE_URL']
end
DB = Sequel.connect(GrapedMoviez.configuration.db_url)
