module GrapedMoviez
  module Models
    DB = Sequel.connect(GrapedMoviez::Configuration.config.db_url)
    class Day < Sequel::Model
      def validate
        super
        errors.add(:day, "can't be blank") if day.empty?
      end
    end
  end
end
