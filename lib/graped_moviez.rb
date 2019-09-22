require "byebug"
require 'graped_moviez/configuration'
require "sequel"
require "date"
require "grape"
require "graped_moviez/version"
require "graped_moviez/api/v1/movies"
require "graped_moviez/api/v1/reservations"
require "graped_moviez/models/movie"
require "graped_moviez/models/reservation"
require "graped_moviez/models/function"
require "graped_moviez/models/day"

module GrapedMoviez
 
  class Error < StandardError; end
  # Your code goes here...
end
