module GrapedMoviez
  module Api
    module V1
      class Movies < Grape::API
        version 'v1', using: :header, vendor: 'graped_moviez'
        format :json
        prefix :api
      end
    end
  end
end
