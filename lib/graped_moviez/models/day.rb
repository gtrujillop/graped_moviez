module GrapedMoviez
  module Models
    DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
    class Day < Sequel::Model
    end
  end
end
