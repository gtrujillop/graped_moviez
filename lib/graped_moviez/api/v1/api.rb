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
        Reservation = GrapedMoviez::Models::Reservation

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
          if movie.save
            { movie: movie.values }
          else
            status 520
            { errors: "Could not create a movie #{movie.errors}"}
          end
        end

        desc 'Creates a day.'
        params do
          requires :day, type: Hash do
            requires :day, type: String
          end
        end
        post :days do
          day = Day.new(
            day: params[:day][:day].to_date
          )
          if day.save
            { day: day.values }
          else
            status 520
            { errors: "Could not create a day #{day.errors}"}
          end
        end

        desc 'Creates a Function from a given movie and date.'
        params do
          requires :function, type: Hash do
            requires :movie, type: String
            requires :day, type: String
          end
        end
        post :functions do
          day = Day.where(day: params[:function][:day]&.to_date).first
          movie = Movie.where(Sequel.lit('LOWER(name) LIKE ?', "#{params[:function][:movie]&.downcase}")).first
          if day && movie
            function = Function.new(
              movie_id: movie.id,
              day_id: day.id,
            )
            if function.save
              serialized_function = {}.tap do |func|
                func[:day] = day.values
                func[:movie] = movie.values
              end
              { function: serialized_function.values }
            else
              status 520
              { errors: "Could not create a function: #{function.errors}"}
            end
          else
            status 400
            { errors: "Could not find the given day or movie. Please check your parameters"}
          end
        end

        desc 'Renders a list of movies by functions.'
        params do
          requires :day, type: String
        end
        get :functions do
          day = Day.where(day: params[:day].to_date).first
          if day
            functions = Function.where(day_id: day.id).each_with_object({}) do |function, hsh|
              hsh[:id] = function.id
              hsh[:day] = function.day.values
              hsh[:movie] = function.movie.values
            end
            { functions: Array.wrap(functions) }
          else
            status 400
            { functions: [] }
          end
        end

        desc 'Creates a reservation.'
        params do
          requires :reservation, type: Hash do
            requires :day, type: String
            requires :movie, type: String
            requires :seats, type: Integer
            requires :user_email, type: String
          end
        end
        post :reservations do
          day = Day.where(day: params[:reservation][:day]&.to_date).first
          movie = Movie.where(Sequel.lit('LOWER(name) LIKE ?', "#{params[:reservation][:movie]&.downcase}")).first
          function = Function.where(movie_id: movie.id, day_id: day.id).first if movie && day
          if function
            reservation = Reservation.new(
              function_id: function.id, 
              seats: params[:reservation][:seats].to_i, 
              user_email: params[:reservation][:user_email]
            )
            if reservation.save
              serialized_reservation = {}.tap do |res|
                res[:id] = reservation.id
                res[:seats] = reservation.seats
                res[:user_email] = reservation.user_email
                res[:day] = reservation.function.day.values
                res[:movie] = reservation.function.movie.values
              end
              { reservation: serialized_reservation }
            else
              status 520
              { error: "there were errors while creating a reservation: #{reservation.errors}" }
            end
          else
            status 404
            { error: "the function for that movie is not available. Please check your parameters." }
          end
        end
      end
    end
  end
end

