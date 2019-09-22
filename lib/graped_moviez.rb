require 'sequel'
require 'date'
require 'grape'
require "graped_moviez/configuration"
require "graped_moviez/version"
require "graped_moviez/api/v1/movies"
require "graped_moviez/api/v1/reservations"
require "graped_moviez/models/movie"
require "graped_moviez/models/reservation"
require "graped_moviez/models/function"
require "graped_moviez/models/day"

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
