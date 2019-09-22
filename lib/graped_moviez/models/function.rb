module GrapedMoviez
  module Models
    DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
    class Function < Sequel::Model
      many_to_one :day
      many_to_one :movie
    end
  end
end
