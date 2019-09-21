module Api
  module v1
    class Movies < Grape::API
      version 'v1', using: :header, vendor: 'graped_moviez'
      format :json
      prefix :api
    end
  end
end
