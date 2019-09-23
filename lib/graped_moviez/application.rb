require "graped_moviez"
require "graped_moviez/api/v1/api"
# Mounting the Grape application
Application = Rack::Builder.new do
  GrapedMoviez::Api::V1::Api.compile
  run GrapedMoviez::Api::V1::Api
end
