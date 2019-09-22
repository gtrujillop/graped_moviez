module GrapedMoviez
  module Models
    DB = Sequel.connect(GrapedMoviez::Configuration.config.db_url)
    class Reservation < Sequel::Model
      many_to_one :function

      def validate
        super
        errors.add(:user_email, "can't be blank") if user_email.nil?
        errors.add(:seats, "can't be 0") if seats.to_i.zero?
        errors.add(:seats, "can't allocate more seats for this function") if function.max_seats_reached?
      end
    end
  end
end
