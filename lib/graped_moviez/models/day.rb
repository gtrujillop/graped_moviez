module GrapedMoviez
  module Models
    DB = Sequel.connect(GrapedMoviez::Configuration.config.db_url)
    class Day < Sequel::Model
      def validate
        super
        errors.add(:day, "can't be blank") if day.nil?
      end

      def self.by_day(day = Date.new)
        Day.where(day: day)
      end
      
    end
  end
end
