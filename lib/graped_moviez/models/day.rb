module GrapedMoviez
  module Models
    DB = Sequel.connect(GrapedMoviez::Configuration.config.db_url)
    class Day < Sequel::Model
      one_to_many :functions

      def validate
        super
        errors.add(:day, "can't be blank") if day.nil?
      end

      def self.by_day(day = Date.new)
        Day.where(day: day)
      end

      def self.by_day_range(start_date: Date.new, end_date: Date.new)
        day_range = start_date..end_date
        Day.where(day: day_range).eager(functions: :reservations)
      end
      
    end
  end
end
