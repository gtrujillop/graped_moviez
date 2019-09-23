require "graped_moviez/models/movie"
module GrapedMoviez
  module Api
    module V1
      class Movies < Grape::API
        version 'v1', using: :header, vendor: 'graped_moviez'
        format :json
        prefix :api

        get :movies do
          { movies: GrapedMoviez::Models::Movie.all.map(&:values) }
        end
      end
    end
  end
end

