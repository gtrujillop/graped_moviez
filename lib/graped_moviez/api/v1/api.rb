require "graped_moviez/api/v1/operations_helper"
require "graped_moviez/models/movie"
require "graped_moviez/models/day"
require "graped_moviez/models/function"
require "graped_moviez/models/reservation"

module GrapedMoviez
  module Api
    module V1
      class Api < Grape::API
        helpers OperationsHelper
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
          render_simple(:movie)
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
          save(movie)
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
          save(day)
        end

        desc 'Creates a Function from a given movie and date.'
        params do
          requires :function, type: Hash do
            requires :movie, type: String
            requires :day, type: String
          end
        end
        post :functions do
          day = Day.by_day(params[:function][:day]&.to_date).first
          movie = Movie.by_name(params[:function][:movie]).first
          if day && movie
            function = Function.new(
              movie_id: movie.id,
              day_id: day.id,
            )
            save(function) do
              {}.tap do |func|
                func[:day] = day.values
                func[:movie] = movie.values
              end
            end
          else
            status 404
            { errors: "Could not find the given day or movie. Please check your parameters"}
          end
        end

        desc 'Renders a list of movies by functions.'
        params do
          requires :day, type: String
        end
        get :functions do
          day = Day.by_day(params[:day].to_date).first
          if day
            functions = Function.by_day(day.id).map do |function|
              {}.tap do |hsh|
                hsh[:id] = function.id
                hsh[:day] = function.day.values
                hsh[:movie] = function.movie.values
              end
            end
            { functions: functions }
          else
            { functions: [] }
          end
        end

        desc 'Renders a list of reservations by time range.'
        params do
          requires :start_date, type: String
          requires :end_date, type: String
        end
        get :reservations do
          days = Day.by_day_range(
            start_date: params[:start_date].to_date,
            end_date: params[:end_date].to_date,
          ).all
          reservations = days.flat_map(&:functions).flat_map(&:reservations) if !days.empty?
          if reservations
            serialized_reservations = reservations.map do |res|
              {}.tap do |hsh|
                hsh[:id] = res.id
                hsh[:day] = res.function.day.values
                hsh[:movie] = res.function.movie.values
                hsh[:seats] = res.seats
                hsh[:user_email] = res.user_email
              end
            end
            { reservations: Array.wrap(serialized_reservations) }
          else
            { reservations: [] }
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
          day = Day.by_day(params[:reservation][:day]&.to_date).first
          movie = Movie.by_name(params[:reservation][:movie]).first
          function = Function.where(movie_id: movie.id, day_id: day.id).first if movie && day
          if function
            reservation = Reservation.new(
              function_id: function.id, 
              seats: params[:reservation][:seats].to_i, 
              user_email: params[:reservation][:user_email]
            )
            save(reservation) do
              {}.tap do |res|
                res[:id] = reservation.id
                res[:seats] = reservation.seats
                res[:user_email] = reservation.user_email
                res[:day] = reservation.function.day.values
                res[:movie] = reservation.function.movie.values
              end
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

