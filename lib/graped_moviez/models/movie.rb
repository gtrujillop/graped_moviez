module GrapedMoviez
  module Models
    DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
    class Movie < Sequel::Model
    end
  end
end
