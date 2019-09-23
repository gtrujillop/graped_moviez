module GrapedMoviez
  module Models
    DB = Sequel.connect(GrapedMoviez::Configuration.config.db_url)
    class Function < Sequel::Model
      many_to_one :day
      many_to_one :movie
      
      MAX_SEATS = 10

      def validate
        super
        errors.add(:day, "can't be blank") if day.nil?
        errors.add(:movie, "can't be blank") if movie.nil?
      end
    end
  end
end
