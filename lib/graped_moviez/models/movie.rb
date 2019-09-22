module GrapedMoviez
  module Models
    DB = Sequel.connect(GrapedMoviez::Configuration.config.db_url)
    class Movie < Sequel::Model
      def validate
        super
        errors.add(:name, "can't be empty") if name.nil?
        errors.add(:description, "can't be empty") if description.nil?
      end
    end
  end
end
