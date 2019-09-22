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

      def seats_reserved
        Reservation.where(function_id: self.id).map(&:seats).reduce(:+)
      end

      def max_seats_reached?
        seats_reserved > MAX_SEATS
      end
    end
  end
end
