module GrapedMoviez
  module Models
    DB = Sequel.connect(GrapedMoviez::Configuration.config.db_url)
    class Movie < Sequel::Model
      def validate
        super
        errors.add(:name, "can't be empty") if name.nil?
        errors.add(:description, "can't be empty") if description.nil?
      end

      def self.by_name(name = nil)
        Movie.where(Sequel.lit('LOWER(name) LIKE ?', "#{name&.downcase}"))
      end
      
    end
  end
end
