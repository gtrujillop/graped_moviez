module GrapedMoviez
  module Models
    DB = Sequel.connect(GrapedMoviez::Configuration.config.db_url)
    class Reservation < Sequel::Model
      many_to_one :function

      def before_create
        self.validate
        super
      end

      def validate
        super
        errors.add(:user_email, "can't be blank") if user_email.nil?
        errors.add(:seats, "can't be 0") if seats.to_i.zero?
        errors.add(:seats, "can't allocate more seats for this function") if max_seats_reached?
      end

      private

      def seats_reserved
        Reservation.where(function_id: self.function_id).map(&:seats).reduce(:+)
      end

      def seats_available
        Function::MAX_SEATS - seats_reserved
      end

      def max_seats_reached?
        self.seats > seats_available
      end
    end
  end
end
