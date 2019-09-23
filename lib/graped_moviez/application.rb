require "graped_moviez"
require "graped_moviez/api/v1/movies"
# Mounting the Grape application
Application = Rack::Builder.new do
  map "/" do
    run GrapedMoviez::Api::V1::Movies
  end
end
