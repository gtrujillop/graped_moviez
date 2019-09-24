module GrapedMoviez
  module Models
    DB = Sequel.connect(GrapedMoviez::Configuration.config.db_url)
    class Function < Sequel::Model
      many_to_one :day
      many_to_one :movie
      one_to_many :reservations
      
      MAX_SEATS = 10

      def validate
        super
        errors.add(:day, "can't be blank") if day.nil?
        errors.add(:movie, "can't be blank") if movie.nil?
      end

      def self.by_day(day_id)
        Function.where(day_id: day_id)
      end

      def self.by_movie(movie_id)
        Movie.where(movie_id: movie_id)
      end
    end
  end
end
