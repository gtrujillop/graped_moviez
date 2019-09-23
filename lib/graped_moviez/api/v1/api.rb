require "graped_moviez/models/movie"
require "graped_moviez/models/day"
require "graped_moviez/models/function"
require "graped_moviez/models/reservation"

module GrapedMoviez
  module Api
    module V1
      class Api < Grape::API
        Movie = GrapedMoviez::Models::Movie
        Function = GrapedMoviez::Models::Function
        Day = GrapedMoviez::Models::Day
        rescue_from :all
        version 'v1', using: :header, vendor: 'graped_moviez'
        format :json
        prefix :api
        
        desc 'Renders a list of movies.'
        get :movies do
          movies = GrapedMoviez::Models::Movie.all.map(&:values)
          { movies: movies }
        end

        desc 'Creates a movie.'
        params do
          requires :movie, type: Hash do
            requires :name, type: String
            requires :description, type: String
            requires :image_url, type: String
          end
        end
        post :movies do
          movie = Movie.new(
            name: params[:movie][:name],
            description: params[:movie][:description],
            image_url: params[:movie][:image_url]
          )
          movie.save
          { movie: movie.values }
        end

        desc 'Renders a list of movies by functions.'
        params do
          requires :day, type: String
        end
        get :functions do
          day = Day.where(day: params[:day].to_date).first
          if day
            functions = Function.where(day_id: day.id).map(&:values) 
            { functions: functions }
          else
            status 400
            { functions: [] }
          end
        end
      end
    end
  end
end

